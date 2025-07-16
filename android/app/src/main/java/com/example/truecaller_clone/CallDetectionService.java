

package com.example.truecaller_clone;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.Service;
import android.content.Intent;
import android.os.Build;
import android.os.IBinder;
import android.telephony.PhoneStateListener;
import android.telephony.TelephonyManager;
import android.util.Log;

public class CallDetectionService extends Service {
    private static final String CHANNEL_ID = "CallDetectionChannel";
    private TelephonyManager telephonyManager;
    private PhoneStateListener phoneStateListener;

    @Override
//    public void onCreate() {
//        super.onCreate();
//        createNotificationChannel();
//        startForeground(1, createNotification());
//        setupPhoneStateListener();
//    }
    public void onCreate() {
        super.onCreate();
        createNotificationChannel();

        Notification notification = createNotification();

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
            // For Android 14+ (API 34+)
            try {
                int fgsType = 0;
                Class<?> serviceClass = Class.forName("android.app.Service");
                for (java.lang.reflect.Field field : serviceClass.getDeclaredFields()) {
                    if (field.getName().startsWith("FOREGROUND_SERVICE_TYPE_")) {
                        if (field.getName().equals("FOREGROUND_SERVICE_TYPE_PHONE_CALL")) {
                            fgsType |= field.getInt(null);
                        }
                    }
                }
                startForeground(1, notification, fgsType);
            } catch (Exception e) {
                // Fallback to regular foreground service
                startForeground(1, notification);
            }
        } else {
            // For older versions
            startForeground(1, notification);
        }

        setupPhoneStateListener();
    }

    private Notification createNotification() {
        return new Notification.Builder(this, CHANNEL_ID)
                .setContentTitle("Call Detection")
                .setContentText("Monitoring calls in background")
                .setSmallIcon(R.drawable.launch_background)
                .setPriority(Notification.PRIORITY_HIGH)
                .build();
    }

    private void createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationChannel channel = new NotificationChannel(
                    CHANNEL_ID,
                    "Call Detection",
                    NotificationManager.IMPORTANCE_HIGH
            );
            NotificationManager manager = getSystemService(NotificationManager.class);
            manager.createNotificationChannel(channel);
        }
    }

    private void setupPhoneStateListener() {
        telephonyManager = (TelephonyManager) getSystemService(TELEPHONY_SERVICE);
        phoneStateListener = new PhoneStateListener() {
            @Override
            public void onCallStateChanged(int state, String phoneNumber) {
                super.onCallStateChanged(state, phoneNumber);
                handleCallState(state, phoneNumber);
            }
        };

        telephonyManager.listen(phoneStateListener, PhoneStateListener.LISTEN_CALL_STATE);
    }

    private void handleCallState(int state, String phoneNumber) {
        switch (state) {
            case TelephonyManager.CALL_STATE_RINGING:
                Log.d("CallDetection", "Incoming call: " + phoneNumber);
                showCallPopup("Incoming call from: " + phoneNumber);
                break;
            case TelephonyManager.CALL_STATE_OFFHOOK:
                Log.d("CallDetection", "Call started: " + phoneNumber);
                break;
            case TelephonyManager.CALL_STATE_IDLE:
                Log.d("CallDetection", "Call ended");
                break;
        }
    }

    private void showCallPopup(String message) {
        Intent overlayIntent = new Intent(this, CallOverlayService.class);
        overlayIntent.putExtra("CALLER_INFO", message);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            startForegroundService(overlayIntent);
        } else {
            startService(overlayIntent);
        }
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        if (telephonyManager != null && phoneStateListener != null) {
            telephonyManager.listen(phoneStateListener, PhoneStateListener.LISTEN_NONE);
        }
    }

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
}