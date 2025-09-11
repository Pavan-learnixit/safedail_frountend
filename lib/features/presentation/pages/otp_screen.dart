import 'package:flutter/material.dart';
import '../../../api_service.dart';

class OtpScreen extends StatefulWidget {
  final String name, email, phone, password;

  OtpScreen({required this.name, required this.email, required this.phone, required this.password});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final otpController = TextEditingController();

  void verifyOtp() async {
    final otp = otpController.text.trim();
    if (otp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter the OTP")),
      );
      return;
    }

    final request = {
      "name": widget.name,
      "email": widget.email,
      "phoneNumber": widget.phone,
      "password": widget.password,
      "otp": otp,
    };

    try {
      final result = await ApiService.signup(request);
      if (result['success']) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'] ?? "Signup failed")),
        );
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verify OTP")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Enter OTP sent to ${widget.phone}", style: TextStyle(fontSize: 16)),
            TextField(controller: otpController, decoration: InputDecoration(labelText: "OTP")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: verifyOtp, child: Text("Verify & Sign Up")),
          ],
        ),
      ),
    );
  }
}
