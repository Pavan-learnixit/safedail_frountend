//package com.example.truecaller_clone;
//
//import android.app.Notification;
//import android.app.NotificationChannel;
//import android.app.NotificationManager;
//import android.app.Service;
//import android.content.Intent;
//import android.os.Build;
//import android.os.IBinder;
//import android.telephony.PhoneStateListener;
//import android.telephony.TelephonyManager;
//
//public class CallDetectionService extends Service {
//
//    private static final String CHANNEL_ID = "CallDetectionServiceChannel";
//
//    @Override
//    public void onCreate() {
//        super.onCreate();
//        createNotificationChannel();
//        Notification notification = new Notification.Builder(this, CHANNEL_ID)
//                .setContentTitle("Call Detection Service")
//                .setContentText("Listening for incoming calls")
//                .setSmallIcon(R.drawable.launch_background)
//                .build();
//        startForeground(1, notification);
//
//        TelephonyManager telephonyManager = (TelephonyManager) getSystemService(TELEPHONY_SERVICE);
//        telephonyManager.listen(new PhoneStateListener() {
//            @Override
//            public void onCallStateChanged(int state, String incomingNumber) {
//                if (state == TelephonyManager.CALL_STATE_RINGING) {
//                    Intent popupIntent = new Intent(CallDetectionService.this, CallPopupActivity.class);
//                    popupIntent.putExtra("CALLER_NUMBER", incomingNumber);
//                    popupIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
//                    startActivity(popupIntent);
//                }
//            }
//        }, PhoneStateListener.LISTEN_CALL_STATE);
//    }
//
//    private void createNotificationChannel() {
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
//            NotificationChannel serviceChannel = new NotificationChannel(
//                    CHANNEL_ID,
//                    "Call Detection Service Channel",
//                    NotificationManager.IMPORTANCE_DEFAULT
//            );
//            NotificationManager manager = getSystemService(NotificationManager.class);
//            manager.createNotificationChannel(serviceChannel);
//        }
//    }
//
//    @Override
//    public IBinder onBind(Intent intent) {
//        return null;
//    }
//}


//package com.example.truecaller_clone;
//
//import android.app.Notification;
//import android.app.NotificationChannel;
//import android.app.NotificationManager;
//import android.app.PendingIntent;
//import android.app.Service;
//import android.content.Intent;
//import android.os.Build;
//import android.os.IBinder;
//import android.telephony.PhoneStateListener;
//import android.telephony.TelephonyManager;
//
//public class CallDetectionService extends Service {
//
//    private static final String CHANNEL_ID = "CallDetectionServiceChannel";
//
//    @Override
//    public void onCreate() {
//        super.onCreate();
//        createNotificationChannel();
//        Notification notification = new Notification.Builder(this, CHANNEL_ID)
//                .setContentTitle("Call Detection Service")
//                .setContentText("Listening for incoming calls")
//                .setSmallIcon(R.drawable.launch_background)
//                .build();
//        startForeground(1, notification);
//
//        TelephonyManager telephonyManager = (TelephonyManager) getSystemService(TELEPHONY_SERVICE);
//        telephonyManager.listen(new PhoneStateListener() {
//            @Override
//            public void onCallStateChanged(int state, String incomingNumber) {
//                switch (state) {
//                    case TelephonyManager.CALL_STATE_RINGING:
//                        showPopup("Incoming call from: " + incomingNumber);
//                        break;
//                    case TelephonyManager.CALL_STATE_OFFHOOK:
//                        showPopup("Call started with: " + incomingNumber);
//                        break;
//                    case TelephonyManager.CALL_STATE_IDLE:
//                        showPopup("Call ended");
//                        break;
//                }
//            }
//
////            private void showPopup(String message) {
////                Intent popupIntent = new Intent(CallDetectionService.this, CallPopupActivity.class);
////                popupIntent.putExtra("CALLER_NUMBER", message);
////
////                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
////                    popupIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK);
////                    PendingIntent pendingIntent = PendingIntent.getActivity(CallDetectionService.this, 0, popupIntent, PendingIntent.FLAG_IMMUTABLE);
////
////                    Notification popupNotification = new Notification.Builder(CallDetectionService.this, CHANNEL_ID)
////                            .setContentTitle("Call Event")
////                            .setContentText(message)
////                            .setSmallIcon(R.drawable.launch_background)
////                            .setContentIntent(pendingIntent)
////                            .setAutoCancel(true)
////                            .build();
////
////                    NotificationManager manager = (NotificationManager) getSystemService(NOTIFICATION_SERVICE);
////                    manager.notify(2, popupNotification);
////                } else {
////                    popupIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
////                    startActivity(popupIntent);
////                }
////            }
//private void showPopup(String message) {
//    Intent overlayIntent = new Intent(CallDetectionService.this, CallOverlayService.class);
//    overlayIntent.putExtra("CALLER_INFO", message);
//    startService(overlayIntent);
//}
//
//        }, PhoneStateListener.LISTEN_CALL_STATE);
//    }
//
//    private void createNotificationChannel() {
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
//            NotificationChannel serviceChannel = new NotificationChannel(
//                    CHANNEL_ID,
//                    "Call Detection Service Channel",
//                    NotificationManager.IMPORTANCE_DEFAULT
//            );
//            NotificationManager manager = getSystemService(NotificationManager.class);
//            manager.createNotificationChannel(serviceChannel);
//        }
//    }
//
//    @Override
//    public IBinder onBind(Intent intent) {
//        return null;
//    }
//}
//
//package com.example.truecaller_clone;
//
//import android.app.Notification;
//import android.app.NotificationChannel;
//import android.app.NotificationManager;
//import android.app.Service;
//import android.content.Intent;
//import android.os.Build;
//import android.os.IBinder;
//import android.telephony.PhoneStateListener;
//import android.telephony.TelephonyManager;
//import android.util.Log;
//
//public class CallDetectionService extends Service {
//    private static final String CHANNEL_ID = "CallDetectionChannel";
//    private TelephonyManager telephonyManager;
//    private PhoneStateListener phoneStateListener;
//
//    @Override
//    public void onCreate() {
//        super.onCreate();
//        createNotificationChannel();
//        startForeground(1, createNotification());
//        setupPhoneStateListener();
//    }
//
//    private Notification createNotification() {
//        return new Notification.Builder(this, CHANNEL_ID)
//                .setContentTitle("Call Detection")
//                .setContentText("Monitoring calls in background")
//                .setSmallIcon(R.drawable.launch_background)
//                .setPriority(Notification.PRIORITY_HIGH)
//                .build();
//    }
//
//    private void createNotificationChannel() {
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
//            NotificationChannel channel = new NotificationChannel(
//                    CHANNEL_ID,
//                    "Call Detection",
//                    NotificationManager.IMPORTANCE_HIGH
//            );
//            NotificationManager manager = getSystemService(NotificationManager.class);
//            manager.createNotificationChannel(channel);
//        }
//    }
//
//    private void setupPhoneStateListener() {
//        telephonyManager = (TelephonyManager) getSystemService(TELEPHONY_SERVICE);
//        phoneStateListener = new PhoneStateListener() {
//            @Override
//            public void onCallStateChanged(int state, String phoneNumber) {
//                super.onCallStateChanged(state, phoneNumber);
//                handleCallState(state, phoneNumber);
//            }
//        };
//
//        // Register listener with all possible events
//        telephonyManager.listen(phoneStateListener,
//                PhoneStateListener.LISTEN_CALL_STATE |
//                        PhoneStateListener.LISTEN_CALL_FORWARDING_INDICATOR |
//                        PhoneStateListener.LISTEN_SERVICE_STATE);
//    }
//
//    private void handleCallState(int state, String phoneNumber) {
//        switch (state) {
//            case TelephonyManager.CALL_STATE_RINGING:
//                Log.d("CallDetection", "Incoming call: " + phoneNumber);
//                showCallPopup("Incoming call from: " + phoneNumber);
//                break;
//            case TelephonyManager.CALL_STATE_OFFHOOK:
//                Log.d("CallDetection", "Call started: " + phoneNumber);
//                showCallPopup("Call started with: " + phoneNumber);
//                break;
//            case TelephonyManager.CALL_STATE_IDLE:
//                Log.d("CallDetection", "Call ended");
//                showCallPopup("Call ended");
//                break;
//        }
//    }
//
//    private void showCallPopup(String message) {
//        Intent overlayIntent = new Intent(this, CallOverlayService.class);
//        overlayIntent.putExtra("CALLER_INFO", message);
//
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
//            startForegroundService(overlayIntent);
//        } else {
//            startService(overlayIntent);
//        }
//    }
//
//    @Override
//    public void onDestroy() {
//        super.onDestroy();
//        if (telephonyManager != null && phoneStateListener != null) {
//            telephonyManager.listen(phoneStateListener, PhoneStateListener.LISTEN_NONE);
//        }
//    }
//
//    @Override
//    public IBinder onBind(Intent intent) {
//        return null;
//    }
//}

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