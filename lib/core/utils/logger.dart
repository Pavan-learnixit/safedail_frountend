import 'package:flutter/foundation.dart';

class Logger {
  static void log(String message) {
    if (kDebugMode) {
      debugPrint("🟢 LOG: $message");
    }
  }

  static void error(String message) {
    if (kDebugMode) {
      debugPrint("🔴 ERROR: $message");
    }
  }

  static void warn(String message) {
    if (kDebugMode) {
      debugPrint("🟡 WARNING: $message");
    }
  }

  static void info(String message) {
    if (kDebugMode) {
      debugPrint("🔵 INFO: $message");
    }
  }
}
