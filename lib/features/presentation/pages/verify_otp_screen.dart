import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:truecaller_clone/features/presentation/pages/backup_screen.dart';
import '../../presentation/bloc/user_bloc.dart';
import '../../presentation/bloc/user_events.dart';
import '../../presentation/bloc/user_states.dart';
import '../widgets/custom_bottom_navigation.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String phoneNumber;
  final bool isSignupFlow;
  final Map<String, dynamic>? userDetails;

  const VerifyOtpScreen({
    super.key,
    required this.phoneNumber,
    required this.isSignupFlow,
    this.userDetails,
  });

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  String enteredOtp = '';
  bool isOtpValid = false;
  int resendCooldown = 30;
  bool canResend = false;
  bool isResend = false;
  bool otpSnackbarShown = false;
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is SignupSuccess || state is LoginSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state is SignupSuccess
                      ? "Your account has been created successfully!"
                      : "Login successful"),
                  backgroundColor: colorScheme.primary,
                  duration: const Duration(seconds: 2),
                ),
              );
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context, rootNavigator: true).pushReplacement(
                  MaterialPageRoute(builder: (_) => const BackupScreen()),
                );
              });
            } else if (state is UserError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is OtpSent && isResend) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("OTP resent successfully")),
              );
              startResendCooldown();
              setState(() => isResend = false);
            }
          },
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("assets/images/otpverificationimage.png", width: 200, height: 200),
                    const SizedBox(height: 16),
                    Text(
                      "Verify OTP",
                      style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "OTP sent to +91 ${widget.phoneNumber}",
                      style: textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    OTPTextField(
                      length: 6,
                      width: MediaQuery.of(context).size.width,
                      fieldWidth: 40,
                      style: Theme.of(context).textTheme.bodyLarge ?? const TextStyle(fontSize: 17),
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldStyle: FieldStyle.box,
                      otpFieldStyle: OtpFieldStyle(
                        borderColor: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                focusBorderColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                enabledBorderColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                disabledBorderColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),

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
                          style: textTheme.bodySmall?.copyWith(color: colorScheme.error),
                        ),
                      ),
                    const SizedBox(height: 24),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        final isVerifying = state is UserLoading;
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.primary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: isVerifying || !isOtpValid
                              ? null
                              : () {
                            if (widget.isSignupFlow && widget.userDetails != null) {
                              final payload = {
                                ...widget.userDetails!,
                                "otp": enteredOtp,
                              };
                              context.read<UserBloc>().add(SignupEvent(payload));
                            } else {
                              context.read<UserBloc>().add(VerifyOtpEvent(widget.phoneNumber, enteredOtp));
                            }
                          },
                          child: isVerifying
                              ? const CircularProgressIndicator()
                              : Text(
                            widget.isSignupFlow ? "Verify & Create Account" : "Verify OTP",
                            style: textTheme.titleMedium?.copyWith(color: colorScheme.onPrimary),
                          ),
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Didn't receive OTP?", style: textTheme.bodySmall),
                        TextButton(
                          onPressed: canResend
                              ? () {
                            setState(() {
                              isResend = true;
                            });
                            context.read<UserBloc>().add(SendOtpEvent(widget.phoneNumber));
                          }
                              : null,
                          child: Text(
                            canResend ? "Resend" : "Resend in $resendCooldown",
                            style: textTheme.bodyMedium?.copyWith(
                              color: canResend ? colorScheme.primary : colorScheme.onSurfaceVariant,
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
        ),
      ),
    );
  }

}
