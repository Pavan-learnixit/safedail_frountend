import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import '../../../api_service.dart';
import '../utilities/token_storage.dart';
import '../widgets/custom_bottom_navigation.dart';
import 'login_screen.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String phoneNumber;
  final bool isSignupFlow;
  const VerifyOtpScreen({super.key, required this.phoneNumber, required this.isSignupFlow});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}
enum OtpResult { success, invalid, expired, serverError, networkError }
class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  String enteredOtp = '';
  bool isVerifying = false;

  Future<void> verifyOtp() async {
    if (enteredOtp.length != 6 || !RegExp(r'^\d{6}$').hasMatch(enteredOtp)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid 6-digit OTP")),
      );
      return;
    }

    setState(() => isVerifying = true);

    final result = await ApiService().verifyOtp(widget.phoneNumber, enteredOtp);

    if (!mounted) return;
    setState(() => isVerifying = false);
    FocusScope.of(context).unfocus();

    switch (result) {
      case OtpResult.success:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Your account has been created successfully!"),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          Navigator.of(context, rootNavigator: true).pushReplacement(
            MaterialPageRoute(builder: (_) => CustomBottomNaviaionBarScreen()),
          );
        });
        break;

      case OtpResult.invalid:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid OTP. Please try again.")),
        );
        break;

      case OtpResult.expired:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("OTP expired. Request a new one.")),
        );
        break;

      case OtpResult.serverError:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Server error. Please try later.")),
        );
        break;

      case OtpResult.networkError:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Network error. Check your connection.")),
        );
        break;
    }
  }

  bool isOtpValid = false;
  int resendCooldown = 30; // seconds
  bool canResend = false;
  Timer? _resendTimer;
  void startResendCooldown() {
    setState(() {
      canResend = false;
      resendCooldown = 30;
    });

    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendCooldown == 0) {
        timer.cancel();
        setState(() => canResend = true);
      } else {
        setState(() => resendCooldown--);
      }
    });
  }
  Future<void> resendOtp() async {
    if (!canResend) return;

    try {
      final response = await ApiService.sendOtp(widget.phoneNumber);

      if (!mounted) return;

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("OTP resent successfully")),
        );
        startResendCooldown();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to resend OTP: ${response.statusCode}")),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error resending OTP")),
      );
    }
  }
  @override
  void initState() {
    super.initState();
    startResendCooldown();
  }
  @override
  void dispose() {
    _resendTimer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfbfafa),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset("assets/images/otpverificationimage.png", width: 200, height: 200),
                const SizedBox(height: 16),
                const Text(
                  "Verify OTP",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 8),
                Text("OTP sent to +91 ${widget.phoneNumber}", style: const TextStyle(fontSize: 15)),
                const SizedBox(height: 24),
                OTPTextField(
                  length: 6,
                  width: MediaQuery.of(context).size.width,
                  fieldWidth: 40,
                  style: const TextStyle(fontSize: 17),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.box,
                  onChanged: (pin) {
                    setState(() {
                      enteredOtp = pin;
                      isOtpValid = pin.length == 6 && RegExp(r'^\d{6}$').hasMatch(pin);
                    });
                  },
                  onCompleted: (pin) {
                    setState(() {
                      enteredOtp = pin;
                      isOtpValid = pin.length == 6 && RegExp(r'^\d{6}$').hasMatch(pin);
                    });
                  },
                ),
                if (!isOtpValid && enteredOtp.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "OTP must be 6 digits",
                      style: TextStyle(color: Colors.red, fontSize: 13),
                    ),
                  ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade500,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: (isVerifying || !isOtpValid) ? null : verifyOtp,
                  child: isVerifying
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(widget.isSignupFlow
                      ? "Verify & Create Account"
                      : "Verify OTP",
                    style: const TextStyle(fontSize: 22, color: Colors.white),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Didn't receive OTP?", style: TextStyle(fontSize: 14)),
                    TextButton(
                      onPressed: canResend ? resendOtp : null,
                      child: Text(
                        canResend ? "Resend" : "Resend in $resendCooldown",
                        style: TextStyle(
                          color: canResend ? Colors.blueAccent : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
