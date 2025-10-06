import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_states.dart';
import '../controllers/signup_controller.dart';
import 'login_screen.dart';
import 'verify_otp_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  late final SignupController controller;

  bool isEmailValid = true;
  bool isPhoneValid = false;
  bool isFirstNameValid = true;

  @override
  void initState() {
    super.initState();
    controller = SignupController(
      firstNameController: firstNameController,
      lastNameController: lastNameController,
      emailController: emailController,
      phoneController: phoneController,
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  InputDecoration customInput({
    required String hint,
    required IconData icon,
    String? prefixText,
    String? errorText,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InputDecoration(
      hintText: hint,
      counterText: "",
      prefixText: prefixText,
      errorText: errorText,
      filled: true,
      fillColor: colorScheme.surfaceVariant,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      prefixIcon: Icon(icon, color: colorScheme.onSurfaceVariant),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Signup',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,

      body: SafeArea(
        child: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is OtpSent|| state is OtpVerified) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("OTP sent successfully")),
              );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<UserBloc>(),
                    child: VerifyOtpScreen(
                      phoneNumber: phoneController.text.trim(),
                      isSignupFlow: true,
                      userDetails: {
                        "name": "${firstNameController.text.trim()} ${lastNameController.text.trim()}",
                        "email": emailController.text.trim(),
                        "phoneNumber": phoneController.text.trim(),
                        "password": "dummy-password",
                      },
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
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: Image.asset("assets/images/signupimage.png", fit: BoxFit.cover),
                    ),
                    Text("Create Account", style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 16),
                    TextField(
                      controller: firstNameController,
                      decoration: customInput(
                        hint: "First Name",
                        icon: Icons.person,
                        errorText: isFirstNameValid || firstNameController.text.isEmpty
                            ? null
                            : "Enter a valid name",
                      ),
                      onChanged: (value) {
                        setState(() {
                          isFirstNameValid = controller.isValidName(value);
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: lastNameController,
                      decoration: customInput(hint: "Last Name", icon: Icons.person_outline),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: emailController,
                      decoration: customInput(
                        hint: "Email",
                        icon: Icons.email,
                        errorText: isEmailValid || emailController.text.isEmpty ? null : "Enter a valid email",
                      ),
                      onChanged: (value) {
                        setState(() {
                          isEmailValid = controller.isValidEmail(value);
                        });
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: phoneController,
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      decoration: customInput(hint: "Phone Number", icon: Icons.phone, prefixText: '+91 '),
                      onChanged: (value) {
                        if (value.length > 10) {
                          phoneController.text = value.substring(0, 10);
                          phoneController.selection = TextSelection.fromPosition(
                            TextPosition(offset: phoneController.text.length),
                          );
                        }
                        setState(() {
                          isPhoneValid = controller.isValidPhone(value);
                        });
                      },
                    ),
                    if (!isPhoneValid && phoneController.text.isNotEmpty)Text("Phone number must be 10 digits", style: TextStyle(color: Theme.of(context).colorScheme.error)),
                    const SizedBox(height: 16),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        final isSendingOtp = state is UserLoading;
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade500,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: isSendingOtp ? null : () => controller.submit(context),
                          child: isSendingOtp
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text("Next", style: TextStyle(fontSize: 22, color: Colors.white)),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account? ", style: Theme.of(context).textTheme.bodyMedium),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: context.read<UserBloc>(),
                                  child: const LoginScreen(),
                                ),
                              ),
                            );
                          },
                          child: Text("Login", style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          )),
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
