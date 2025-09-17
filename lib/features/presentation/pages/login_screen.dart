import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/data/datasources/api_service.dart';
import '../../auth/data/repositories/auth_repository_impl.dart';
import '../../auth/domain/usecases/send_otp_usecase.dart';
import '../../auth/domain/usecases/verify_otp_usecase.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';
import '../bloc/verify_otp_bloc.dart';
import 'verify_otp_screen.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xFFf9f9f9),
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is OtpSentSuccess) {
              Navigator.push(
                context,
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
                      phoneNumber: phoneController.text,
                      isSignupFlow: false,
                    ),
                  ),
                ),
              );

            } else if (state is LoginFailure) {
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
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "Welcome to ",
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                      TextSpan(
                        text: "Safe Dial",
                        style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Text("Enter Your Phone Number To Login", style: TextStyle(fontSize: 17)),
                const SizedBox(height: 24),
                TextField(
                  controller: phoneController,
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                    counterText: "",
                    filled: true,
                    fillColor: Colors.grey.shade200,
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
                  const Text("Phone number must be 10 digits", style: TextStyle(color: Colors.red)),
                const SizedBox(height: 20),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    final isLoading = state is LoginLoading;
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade500,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: isLoading || !isPhoneValid
                            ? null
                            : () => context.read<LoginBloc>().add(
                          SendOtpPressed(phoneController.text),
                        ),
                        child: isLoading
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                            : const Text("Send OTP", style: TextStyle(fontSize: 20, color: Colors.white)),
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
