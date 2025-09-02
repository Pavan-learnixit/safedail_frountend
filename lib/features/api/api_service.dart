import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:truecaller_clone/models/profile.dart';

class ApiService {
  static const String baseUrl =
      "https://safedialservice-281117507819.europe-west1.run.app/api/v1";

  // Send OTP
  static Future<Map<String, dynamic>> sendOtp(String phone) async {
    final response = await http.post(
      Uri.parse("$baseUrl/sendOtp"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"phone": phone}),
    );
    return jsonDecode(response.body);
  }

  // Update Profile (PUT)
  static Future<Map<String, dynamic>> updateProfile(Profile profile) async {
    final response = await http.put(
      Uri.parse("$baseUrl/user/profile"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(profile.toJson()),
    );
    return jsonDecode(response.body);
  }

  // Get Profile
  static Future<Profile> getProfile() async {
    final response = await http.get(Uri.parse("$baseUrl/user/profile"));
    final data = jsonDecode(response.body);
    return Profile.fromJson(data);
  }

  // Sync Contacts
  static Future<Map<String, dynamic>> syncContacts(
      List<Map<String, dynamic>> contacts) async {
    final response = await http.post(
      Uri.parse("$baseUrl/contacts/sync"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"contacts": contacts}),
    );
    return jsonDecode(response.body);
  }
}
