import 'package:flutter/material.dart';
import '../../auth/domain/repositories/auth_repository.dart';

class OtpScreen extends StatefulWidget {
  final AuthRepository authRepository;
  final String name, email, phone, password;

  const OtpScreen({required this.name, required this.email, required this.phone, required this.password, required this.authRepository});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final otpController = TextEditingController();

  void verifyOtp() async {
    final otp = otpController.text.trim();
    if (otp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: const Text("Please enter the OTP")),
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
      final result = await widget.authRepository.signup(request);
      result.fold(
            (failure) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(failure.message)),
        ),
            (response) => Navigator.pushReplacementNamed(context, '/home'),
      );
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify OTP")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Enter OTP sent to ${widget.phone}", style: const TextStyle(fontSize: 16)),
            TextField(controller: otpController, decoration: const InputDecoration(labelText: "OTP")),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: verifyOtp, child: const Text("Verify & Sign Up")),
          ],
        ),
      ),
    );
  }
}
