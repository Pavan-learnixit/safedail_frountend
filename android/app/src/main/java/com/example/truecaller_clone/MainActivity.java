//
//package com.example.truecaller_clone;
//
//import io.flutter.embedding.android.FlutterActivity;
//import io.flutter.embedding.engine.FlutterEngine;
//import io.flutter.plugin.common.MethodChannel;
//import android.content.Intent;
//import android.app.role.RoleManager;
//import android.os.Build;
//import android.provider.Settings;
//
//public class MainActivity extends FlutterActivity {
//    private static final String CHANNEL = "call_detection_channel";
//
//    @Override
//    public void configureFlutterEngine(FlutterEngine flutterEngine) {
//        super.configureFlutterEngine(flutterEngine);
//
//        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
//                .setMethodCallHandler(
//                        (call, result) -> {
//                            if (call.method.equals("startCallService")) {
//                                Intent intent = new Intent(this, CallDetectionService.class);
//                                if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
//                                    startForegroundService(intent);
//                                } else {
//                                    startService(intent);
//                                }
//                                result.success("Service started");
//                            } else if (call.method.equals("requestDialerRole")) {
//                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
//                                    RoleManager roleManager = getSystemService(RoleManager.class);
//                                    if (roleManager != null && roleManager.isRoleAvailable(RoleManager.ROLE_DIALER)) {
//                                        Intent roleIntent = roleManager.createRequestRoleIntent(RoleManager.ROLE_DIALER);
//                                        startActivity(roleIntent);
//                                        result.success("Dialer role requested");
//                                    } else {
//                                        result.error("ROLE_UNAVAILABLE", "Dialer role is not available", null);
//                                    }
//                                } else {
//                                    result.error("UNSUPPORTED_VERSION", "RoleManager requires Android 10+", null);
//                                }
//                            } else {
//                                result.notImplemented();
//                            }
//                        }
//                );
//    }
//}

package com.example.truecaller_clone;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import android.content.Intent;
import android.app.role.RoleManager;
import android.os.Build;
import android.provider.Settings;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "call_detection_channel";

    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("startCallService")) {
                                Intent intent = new Intent(this, CallDetectionService.class);
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                                    startForegroundService(intent);
                                } else {
                                    startService(intent);
                                }
                                result.success("Service started");
                            } else if (call.method.equals("requestDialerRole")) {
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                                    RoleManager roleManager = getSystemService(RoleManager.class);
                                    if (roleManager != null && roleManager.isRoleAvailable(RoleManager.ROLE_DIALER)) {
                                        Intent roleIntent = roleManager.createRequestRoleIntent(RoleManager.ROLE_DIALER);
                                        startActivity(roleIntent);
                                        result.success("Dialer role requested");
                                    } else {
                                        result.error("ROLE_UNAVAILABLE", "Dialer role is not available", null);
                                    }
                                } else {
                                    result.error("UNSUPPORTED_VERSION", "RoleManager requires Android 10+", null);
                                }
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }
}