import 'package:flutter/services.dart';
import 'dart:convert';

class SmsService {
  static const platform = MethodChannel('call_detection_channel');

  static Future<List<Map<String, String>>> getSmsMessages() async {
    try {
      final String result = await platform.invokeMethod('getSmsMessages');
      final List<dynamic> decoded = jsonDecode(result);

      return decoded.map<Map<String, String>>((item) {
        return {
          "address": item["address"]?.toString() ?? "",
          "body": item["body"]?.toString() ?? "",
          "date": item["date"]?.toString() ?? "",
        };
      }).toList();
    } catch (e) {
      print("Failed to get SMS: $e");
      return [];
    }
  }
}
