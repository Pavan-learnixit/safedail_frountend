//// CallOverlayService.java
//package com.example.truecaller_clone;
//
//import android.app.Service;
//import android.content.Intent;
//import android.graphics.PixelFormat;
//import android.os.Build;
//import android.os.Handler;
//import android.os.IBinder;
//import android.os.Looper;
//import android.provider.Settings;
//import android.view.Gravity;
//import android.view.LayoutInflater;
//import android.view.View;
//import android.view.WindowManager;
//import android.widget.TextView;
//
//public class CallOverlayService extends Service {
//
//    private WindowManager windowManager;
//    private View popupView;
//
//    @Override
//    public int onStartCommand(Intent intent, int flags, int startId) {
//        String callerInfo = intent.getStringExtra("CALLER_INFO");
//        showOverlayPopup(callerInfo);
//        return START_NOT_STICKY;
//    }
//
//    private void showOverlayPopup(String message) {
//        if (Settings.canDrawOverlays(this)) {
//            windowManager = (WindowManager) getSystemService(WINDOW_SERVICE);
//            LayoutInflater inflater = (LayoutInflater) getSystemService(LAYOUT_INFLATER_SERVICE);
//            popupView = inflater.inflate(R.layout.call_popup, null);
//
//            TextView textView = popupView.findViewById(R.id.popup_text);
//            textView.setText(message);
//
//            WindowManager.LayoutParams params = new WindowManager.LayoutParams(
//                    WindowManager.LayoutParams.WRAP_CONTENT,
//                    WindowManager.LayoutParams.WRAP_CONTENT,
//                    Build.VERSION.SDK_INT >= Build.VERSION_CODES.O ?
//                            WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY :
//                            WindowManager.LayoutParams.TYPE_PHONE,
//                    WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE |
//                            WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN |
//                            WindowManager.LayoutParams.FLAG_NOT_TOUCH_MODAL,
//                    PixelFormat.TRANSLUCENT);
//
//            params.gravity = Gravity.TOP | Gravity.CENTER_HORIZONTAL;
//            windowManager.addView(popupView, params);
//
//            new Handler(Looper.getMainLooper()).postDelayed(() -> {
//                if (popupView != null) {
//                    windowManager.removeView(popupView);
//                    popupView = null;
//                }
//            }, 5000);
//        } else {
//            Intent overlayIntent = new Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION);
//            overlayIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
//            overlayIntent.setData(android.net.Uri.parse("package:" + getPackageName()));
//            startActivity(overlayIntent);
//        }
//    }
//
//    @Override
//    public IBinder onBind(Intent intent) {
//        return null;
//    }
//
//    @Override
//    public void onDestroy() {
//        super.onDestroy();
//        if (popupView != null && windowManager != null) {
//            windowManager.removeView(popupView);
//        }
//    }
//}
//package com.example.truecaller_clone;
//
//import android.app.Service;
//import android.content.Intent;
//import android.graphics.PixelFormat;
//import android.net.Uri;
//import android.os.Build;
//import android.os.Handler;
//import android.os.IBinder;
//import android.os.Looper;
//import android.provider.Settings;
//import android.view.Gravity;
//import android.view.LayoutInflater;
//import android.view.View;
//import android.view.WindowManager;
//import android.widget.TextView;
//
//public class CallOverlayService extends Service {
//
//    private WindowManager windowManager;
//    private View popupView;
//
//    @Override
//    public int onStartCommand(Intent intent, int flags, int startId) {
//        String callerInfo = intent.getStringExtra("CALLER_INFO");
//
//        if (!Settings.canDrawOverlays(this)) {
//            requestOverlayPermission();
//        } else {
//            showOverlayPopup(callerInfo);
//        }
//
//        return START_NOT_STICKY;
//    }
//
//    private void requestOverlayPermission() {
//        Intent overlayIntent = new Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION,
//                Uri.parse("package:" + getPackageName()));
//        overlayIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
//        startActivity(overlayIntent);
//    }
//
//    private void showOverlayPopup(String message) {
//        windowManager = (WindowManager) getSystemService(WINDOW_SERVICE);
//        LayoutInflater inflater = (LayoutInflater) getSystemService(LAYOUT_INFLATER_SERVICE);
//        popupView = inflater.inflate(R.layout.call_popup, null);
//
//        TextView textView = popupView.findViewById(R.id.popup_text);
//        textView.setText(message);
//
//        WindowManager.LayoutParams params = new WindowManager.LayoutParams(
//                WindowManager.LayoutParams.WRAP_CONTENT,
//                WindowManager.LayoutParams.WRAP_CONTENT,
//                Build.VERSION.SDK_INT >= Build.VERSION_CODES.O ?
//                        WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY :
//                        WindowManager.LayoutParams.TYPE_PHONE,
//                WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE |
//                        WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN |
//                        WindowManager.LayoutParams.FLAG_NOT_TOUCH_MODAL,
//                PixelFormat.TRANSLUCENT);
//
//        params.gravity = Gravity.TOP | Gravity.CENTER_HORIZONTAL;
//        params.y = 100;
//
//        windowManager.addView(popupView, params);
//
//        // Remove after 5 seconds
//        new Handler(Looper.getMainLooper()).postDelayed(() -> {
//            if (popupView != null && windowManager != null) {
//                try {
//                    windowManager.removeView(popupView);
//                    popupView = null;
//                } catch (Exception e) {
//                    e.printStackTrace();
//                }
//            }
//        }, 5000);
//    }
//
//    @Override
//    public void onDestroy() {
//        super.onDestroy();
//        if (popupView != null && windowManager != null) {
//            try {
//                windowManager.removeView(popupView);
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
//            popupView = null;
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
//import android.app.Service;
//import android.content.Intent;
//import android.graphics.PixelFormat;
//import android.net.Uri;
//import android.os.Build;
//import android.os.Handler;
//import android.os.IBinder;
//import android.provider.Settings;
//import android.view.Gravity;
//import android.view.LayoutInflater;
//import android.view.View;
//import android.view.WindowManager;
//import android.widget.TextView;
//
//public class CallOverlayService extends Service {
//    private WindowManager windowManager;
//    private View overlayView;
//    private Handler handler;
//
//    @Override
//    public void onCreate() {
//        super.onCreate();
//        handler = new Handler();
//    }
//
//    @Override
//    public int onStartCommand(Intent intent, int flags, int startId) {
//        if (intent != null && intent.hasExtra("CALLER_INFO")) {
//            String callerInfo = intent.getStringExtra("CALLER_INFO");
//            showOverlay(callerInfo);
//        }
//        return START_NOT_STICKY;
//    }
//
//    private void showOverlay(String message) {
//        if (!Settings.canDrawOverlays(this)) {
//            requestOverlayPermission();
//            return;
//        }
//
//        windowManager = (WindowManager) getSystemService(WINDOW_SERVICE);
//        LayoutInflater inflater = (LayoutInflater) getSystemService(LAYOUT_INFLATER_SERVICE);
//        overlayView = inflater.inflate(R.layout.call_popup, null);
//
//        TextView textView = overlayView.findViewById(R.id.popup_text);
//        textView.setText(message);
//
//        WindowManager.LayoutParams params = new WindowManager.LayoutParams(
//                WindowManager.LayoutParams.WRAP_CONTENT,
//                WindowManager.LayoutParams.WRAP_CONTENT,
//                Build.VERSION.SDK_INT >= Build.VERSION_CODES.O ?
//                        WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY :
//                        WindowManager.LayoutParams.TYPE_PHONE,
//                WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE |
//                        WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN |
//                        WindowManager.LayoutParams.FLAG_NOT_TOUCH_MODAL,
//                PixelFormat.TRANSLUCENT);
//
//        params.gravity = Gravity.TOP | Gravity.CENTER_HORIZONTAL;
//        params.y = 100;
//
//        try {
//            windowManager.addView(overlayView, params);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        // Auto-remove after 5 seconds
//        handler.postDelayed(() -> removeOverlay(), 5000);
//    }
//
//    private void requestOverlayPermission() {
//        Intent intent = new Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION,
//                Uri.parse("package:" + getPackageName()));
//        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
//        startActivity(intent);
//    }
//
//    private void removeOverlay() {
//        if (overlayView != null && windowManager != null) {
//            try {
//                windowManager.removeView(overlayView);
//                overlayView = null;
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
//        }
//    }
//
//    @Override
//    public void onDestroy() {
//        super.onDestroy();
//        removeOverlay();
//        handler.removeCallbacksAndMessages(null);
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
import android.graphics.PixelFormat;
import android.net.Uri;
import android.os.Build;
import android.os.Handler;
import android.os.IBinder;
import android.provider.Settings;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.WindowManager;
import android.widget.TextView;

public class CallOverlayService extends Service {
    private static final String CHANNEL_ID = "CallOverlayChannel";
    private WindowManager windowManager;
    private View overlayView;
    private Handler handler;

    @Override
    public void onCreate() {
        super.onCreate();
        handler = new Handler();
        createNotificationChannel();
    }

    @Override
//    public int onStartCommand(Intent intent, int flags, int startId) {
//        // Start as foreground service immediately
//        Notification notification = new Notification.Builder(this, CHANNEL_ID)
//                .setContentTitle("Call Detection")
//                .setContentText("Showing call information")
//                .setSmallIcon(R.drawable.launch_background)
//                .build();
////        startForeground(1, notification);
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
//            startForeground(1, notification, Service.FOREGROUND_SERVICE_TYPE_SPECIAL_USE);
//        } else {
//            startForeground(1, notification);
//        }
//
//        if (intent != null && intent.hasExtra("CALLER_INFO")) {
//            String callerInfo = intent.getStringExtra("CALLER_INFO");
//            showOverlay(callerInfo);
//        }
//        return START_NOT_STICKY;
//    }

    public int onStartCommand(Intent intent, int flags, int startId) {
        Notification notification = new Notification.Builder(this, CHANNEL_ID)
                .setContentTitle("Call Detection")
                .setContentText("Showing call information")
                .setSmallIcon(R.drawable.launch_background)
                .build();

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
            // For Android 14+ (API 34+)
            try {
                int fgsType = 0;
                Class<?> serviceClass = Class.forName("android.app.Service");
                for (java.lang.reflect.Field field : serviceClass.getDeclaredFields()) {
                    if (field.getName().startsWith("FOREGROUND_SERVICE_TYPE_")) {
                        if (field.getName().equals("FOREGROUND_SERVICE_TYPE_SPECIAL_USE")) {
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

        if (intent != null && intent.hasExtra("CALLER_INFO")) {
            String callerInfo = intent.getStringExtra("CALLER_INFO");
            showOverlay(callerInfo);
        }
        return START_NOT_STICKY;
    }

    private void createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationChannel channel = new NotificationChannel(
                    CHANNEL_ID,
                    "Call Overlay",
                    NotificationManager.IMPORTANCE_LOW
            );
            NotificationManager manager = getSystemService(NotificationManager.class);
            manager.createNotificationChannel(channel);
        }
    }

    private void showOverlay(String message) {
        if (!Settings.canDrawOverlays(this)) {
            requestOverlayPermission();
            return;
        }

        windowManager = (WindowManager) getSystemService(WINDOW_SERVICE);
        LayoutInflater inflater = (LayoutInflater) getSystemService(LAYOUT_INFLATER_SERVICE);
        overlayView = inflater.inflate(R.layout.call_popup, null);

        TextView textView = overlayView.findViewById(R.id.popup_text);
        textView.setText(message);

        WindowManager.LayoutParams params = new WindowManager.LayoutParams(
                WindowManager.LayoutParams.WRAP_CONTENT,
                WindowManager.LayoutParams.WRAP_CONTENT,
                Build.VERSION.SDK_INT >= Build.VERSION_CODES.O ?
                        WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY :
                        WindowManager.LayoutParams.TYPE_PHONE,
                WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE |
                        WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN |
                        WindowManager.LayoutParams.FLAG_NOT_TOUCH_MODAL,
                PixelFormat.TRANSLUCENT);

        params.gravity = Gravity.TOP | Gravity.CENTER_HORIZONTAL;
        params.y = 100;

        try {
            windowManager.addView(overlayView, params);
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Auto-remove after 5 seconds
        handler.postDelayed(() -> removeOverlay(), 5000);
    }

    private void requestOverlayPermission() {
        Intent intent = new Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION,
                Uri.parse("package:" + getPackageName()));
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(intent);
    }

    private void removeOverlay() {
        if (overlayView != null && windowManager != null) {
            try {
                windowManager.removeView(overlayView);
                overlayView = null;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        removeOverlay();
        if (handler != null) {
            handler.removeCallbacksAndMessages(null);
        }
    }

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
}