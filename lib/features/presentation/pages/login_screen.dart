import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_bloc.dart';
import 'package:truecaller_clone/features/presentation/bloc/user_events.dart';
import 'package:truecaller_clone/features/presentation/bloc/user_states.dart';
import 'package:truecaller_clone/features/presentation/pages/verify_otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  bool get isPhoneValid => phoneController.text.length == 10;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Login',
          style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: colorScheme.onBackground,
      ),
      body: SafeArea(
        child: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is OtpSent) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<UserBloc>(),
                    child: VerifyOtpScreen(
                      phoneNumber: phoneController.text,
                      isSignupFlow: false,
                    ),
                  ),
                ),
              );
            } else if (state is UserError) {
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
                Image.asset("assets/images/loginimage.png", width: 200, height: 200),
                const SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Welcome to ",
                        style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      TextSpan(
                        text: "Safe Dial",
                        style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Enter Your Phone Number To Login",
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: phoneController,
                  maxLength: 10,
                  keyboardType: TextInputType.number, // better than phone for digits only
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // restricts to numbers
                  ],
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                    counterText: "",
                    filled: true,
                    fillColor: colorScheme.surfaceVariant,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  onChanged: (value) {
                    if (value.length > 10) {
                      phoneController.text = value.substring(0, 10);
                      phoneController.selection = TextSelection.fromPosition(
                        TextPosition(offset: phoneController.text.length),
                      );
                    }
                    setState(() {});
                  },
                ),
                if (!isPhoneValid && phoneController.text.isNotEmpty)
                  Text(
                    "Phone number must be 10 digits",
                    style: TextStyle(color: colorScheme.error),
                  ),
                const SizedBox(height: 20),
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    final isLoading = state is UserLoading;

                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: isLoading || !isPhoneValid
                            ? null
                            : () => context.read<UserBloc>().add(SendOtpEvent(phoneController.text)),
                        child: isLoading
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                            : Text(
                          "Send OTP",
                          style: textTheme.titleMedium?.copyWith(color: colorScheme.onPrimary),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
