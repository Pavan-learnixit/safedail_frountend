import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import '../bloc/verify_otp_bloc.dart';
import '../bloc/verify_otp_event.dart';
import '../bloc/verify_otp_state.dart';
import '../widgets/custom_bottom_navigation.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String phoneNumber;
  final bool isSignupFlow;

  const VerifyOtpScreen({
    super.key,
    required this.phoneNumber,
    required this.isSignupFlow,
  });

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  String enteredOtp = '';
  bool isOtpValid = false;
  int resendCooldown = 30;
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
        child: BlocListener<VerifyOtpBloc, VerifyOtpState>(
          listener: (context, state) {
            if (state is VerifyOtpSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Your account has been created successfully!"),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 2),
                ),
              );
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context, rootNavigator: true).pushReplacement(
                  MaterialPageRoute(builder: (_) => CustomBottomNaviaionBarScreen()),
                );
              });
            } else if (state is VerifyOtpFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is ResendOtpSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("OTP resent successfully")),
              );
              startResendCooldown();
            } else if (state is ResendOtpFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset("assets/images/otpverificationimage.png", width: 200, height: 200),
                const SizedBox(height: 16),
                const Text("Verify OTP", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black)),
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
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text("OTP must be 6 digits", style: TextStyle(color: Colors.red, fontSize: 13)),
                  ),
                const SizedBox(height: 24),
                BlocBuilder<VerifyOtpBloc, VerifyOtpState>(
                  builder: (context, state) {
                    final isVerifying = state is VerifyOtpLoading;
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade500,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: isVerifying || !isOtpValid
                          ? null
                          : () => context.read<VerifyOtpBloc>().add(
                        VerifyOtpSubmitted(widget.phoneNumber, enteredOtp),
                      ),
                      child: isVerifying
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                        widget.isSignupFlow ? "Verify & Create Account" : "Verify OTP",
                        style: const TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Didn't receive OTP?", style: TextStyle(fontSize: 14)),
                    TextButton(
                      onPressed: canResend
                          ? () => context.read<VerifyOtpBloc>().add(
                        ResendOtpRequested(widget.phoneNumber),
                      )
                          : null,
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
