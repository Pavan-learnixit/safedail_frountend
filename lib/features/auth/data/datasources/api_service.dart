import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import '../../../../core/utils/token_storage.dart';
import '../../domain/entities/profile.dart';
import '../../domain/entities/otp_result.dart';
import '../../domain/entities/signup_response.dart';

@injectable
class ApiService {
  static const String baseUrl =
      "https://safedialservice-281117507819.europe-west1.run.app/api/v1";

  Future<http.Response> sendOtp(String phoneNumber) async {
    final url = Uri.parse("$baseUrl/sendotp");
    print("Sending OTP to: $phoneNumber");
    print("Request URL: $url");

    try {
      final response = await http
          .post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phoneNumber": phoneNumber}),
      )
          .timeout(const Duration(seconds: 10));

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      return response;
    } catch (e) {
      print("Error in sendOtp: $e");
      rethrow;
    }
  }

  Future<OtpResult> verifyOtp(String phone, String otp) async {
    final url = Uri.parse("$baseUrl/verifyOtp");
    debugPrint("Verifying OTP for $phone at $url");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({"phoneNumber": phone, "otp": otp}),
      );

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final success = data["success"] == true;

        if (success) {
          final token = data["token"];
          if (token != null && token is String) {
            await TokenStorage.saveToken(token);
            debugPrint("Token saved: $token");
          }
          return OtpResult.success;
        } else {
          debugPrint("Success flag is false");
          return OtpResult.invalid;
        }
      } else if (response.statusCode == 401) {
        return OtpResult.invalid;
      } else if (response.statusCode == 403) {
        return OtpResult.expired;
      } else {
        debugPrint("Unexpected status code: ${response.statusCode}");
        return OtpResult.serverError;
      }
    } catch (e) {
      debugPrint("Network error during OTP verification: $e");
      return OtpResult.networkError;
    }
  }
  Future<SignupResponse> signup(Map<String, dynamic> payload) async {
    final url = Uri.parse("$baseUrl/signup");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payload),
      );

      final data = jsonDecode(response.body);
      return SignupResponse.fromJson(data);
    } catch (e) {
      return SignupResponse(success: false, message: "Exception: $e");
    }
  }

  Future<Map<String, dynamic>> logout() async {
    final url = Uri.parse("$baseUrl/logout");
    final token = await TokenStorage.getToken();

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      debugPrint("Logout status: ${response.statusCode}");
      debugPrint("Logout response: ${response.body}");

      if (response.statusCode == 200) {
        await TokenStorage.clearToken(); // Clear saved token
        return {"success": true, "message": "Logged out successfully"};
      } else {
        return {
          "success": false,
          "message": "Logout failed: ${response.statusCode}"
        };
      }
    } catch (e) {
      debugPrint("Logout error: $e");
      return {"success": false, "message": "Network error: $e"};
    }
  }
  // Update Profile (PUT)
  Future<Map<String, dynamic>> updateProfile(Profile profile) async {
    final token = await TokenStorage.getToken();

    final response = await http.put(
      Uri.parse("$baseUrl/user/profile"),
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
      body: jsonEncode(profile.toJson()),
    );
    return jsonDecode(response.body);
  }

  // Get Profile
  Future<Profile> getProfile() async {
    final token = await TokenStorage.getToken();

    final response = await http.get(
      Uri.parse("$baseUrl/user/profile"),
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
    );

    final data = jsonDecode(response.body);
    return Profile.fromJson(data);
  }

  // Sync Contacts
  static Future<Map<String, dynamic>> syncContacts(
      List<Map<String, dynamic>> contacts) async {
    final token = await TokenStorage.getToken();

    final response = await http.post(
      Uri.parse("$baseUrl/contacts/sync"),
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token", // token here
      },
      body: jsonEncode({"contacts": contacts}),
    );
    return jsonDecode(response.body);
  }
}
