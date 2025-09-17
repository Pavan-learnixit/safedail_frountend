import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/data/datasources/api_service.dart';
import '../../auth/data/repositories/auth_repository_impl.dart';
import '../../auth/domain/usecases/send_otp_usecase.dart';
import '../../auth/domain/usecases/verify_otp_usecase.dart';
import '../bloc/signup_event.dart';
import '../bloc/signup_state.dart';
import '../bloc/singup_bloc.dart';
import '../bloc/verify_otp_bloc.dart';
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

  bool isEmailValid = true;
  bool isPhoneValid = false;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  bool validateInputs() {
    if (firstNameController.text.trim().isEmpty) {
      showError("First name is required");
      return false;
    }
    if (phoneController.text.trim().isEmpty) {
      showError("Phone number is required");
      return false;
    }
    return true;
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  InputDecoration customInput({
    required String hint,
    required IconData icon,
    String? prefixText,
    String? errorText,
    bool isPassword = false,
  }) {
    return InputDecoration(
      hintText: hint,
      counterText: "",
      prefixText: prefixText,
      errorText: errorText,
      filled: true,
      fillColor: Colors.grey.shade200,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      prefixIcon: Icon(icon, color: Colors.grey.shade600),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Colors.black)),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      backgroundColor: const Color(0xFFffffff),
      body: SafeArea(
        child: BlocListener<SignupBloc, SignupState>(
          listener: (context, state) {
            if (state is SignupSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("OTP sent successfully")),
              );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider<VerifyOtpBloc>(
                    create: (_) {
                      final apiService = ApiService();
                      final authRepository = AuthRepositoryImpl(apiService);
                      final verifyOtpUseCase = VerifyOtpUseCase(authRepository);
                      final sendOtpUseCase = SendOtpUseCase(authRepository);
                      return VerifyOtpBloc(verifyOtpUseCase, sendOtpUseCase);
                    },
                    child: VerifyOtpScreen(
                      phoneNumber: phoneController.text.trim(),
                      isSignupFlow: true,
                    ),
                  ),
                ),
              );

            } else if (state is SignupFailure) {
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
                    const Text("Create Account", style: TextStyle(fontSize: 28, color: Colors.black)),
                    const SizedBox(height: 16),
                    TextField(
                      controller: firstNameController,
                      decoration: customInput(hint: "First Name", icon: Icons.person),
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
                          isEmailValid = isValidEmail(value);
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
                          isPhoneValid = value.length == 10;
                        });
                      },
                    ),
                    if (!isPhoneValid && phoneController.text.isNotEmpty)
                      const Text("Phone number must be 10 digits", style: TextStyle(color: Colors.red)),
                    const SizedBox(height: 16),
                    BlocBuilder<SignupBloc, SignupState>(
                      builder: (context, state) {
                        final isSendingOtp = state is SignupLoading;
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade500,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: isSendingOtp
                              ? null
                              : () {
                            if (!validateInputs()) return;
                            final payload = {
                              "name": "${firstNameController.text.trim()} ${lastNameController.text.trim()}",
                              "email": emailController.text.trim(),
                              "phoneNumber": phoneController.text.trim(),
                              "password": "dummy-password", // Replace with actual password logic if needed
                            };
                            context.read<SignupBloc>().add(SignupSendOtpPressed(payload));
                          },
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
                        Text("Already have an account? ", style: TextStyle(color: Colors.grey[600], fontSize: 18)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                          },
                          child: const Text("Login", style: TextStyle(fontSize: 20, color: Colors.blue, fontWeight: FontWeight.bold)),
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
