import 'package:flutter/services.dart';

class CallPlatformChannel {
  static const MethodChannel _channel = MethodChannel('call_detection_channel');
 // static const MethodChannel platform = MethodChannel('call_detection_channel');
  static Future<void> startCallService() async {
    try {
      await _channel.invokeMethod('startCallService');
    } catch (e) {
      print("Error starting service: $e");
    }
  }
  static Future<void> requestDialerRole() async {
    try {
      final result = await _channel.invokeMethod('requestDialerRole');
      print(result); // "Dialer role requested"
    } catch (e) {
      print("Failed to request dialer role: $e");
    }
  }
}