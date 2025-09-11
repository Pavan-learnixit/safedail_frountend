import 'package:flutter/material.dart';
import '../../../api_service.dart';
import 'login_screen.dart';
import 'verify_otp_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isEmailValid = true;

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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }


  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }
  bool isSendingOtp = false;
  bool otpSent = false;
  bool isPhoneValid = false;

  Future<void> sendOtp() async {
    final phone = phoneController.text.trim();

    if (phone.length != 10 || !RegExp(r'^\d{10}$').hasMatch(phone)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter a valid 10-digit phone number")),
      );
      return;
    }

    setState(() => isSendingOtp = true);

    try {
      final response = await ApiService.sendOtp(phone); // Your existing OTP API call
      if (response.statusCode == 200) {
        setState(() => otpSent = true);

        await Future.delayed(const Duration(milliseconds: 800)); // Let the message appear

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("OTP sent successfully")),
        );

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => VerifyOtpScreen(phoneNumber: phone, isSignupFlow: true,),
          ),
        );
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to send OTP: ${response.statusCode}")),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error sending OTP")),
      );
    } finally {
      if (mounted) setState(() => isSendingOtp = false);
    }
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
      prefixText: prefixText,// hides character counter if maxLength is set
      filled: true,
      errorText: errorText,
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
        title: const Text(
          'Signup',
          style: TextStyle(
            fontSize: 40, // bigger
            fontWeight: FontWeight.w900, // extra bold
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      backgroundColor: const Color(0xFFffffff),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: Image.asset("assets/images/signupimage.png", fit: BoxFit.cover)),
                  Text("Create Account", style: TextStyle(
                    fontSize: 28,
                    // fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),),
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
                    decoration: customInput(hint: "Phone Number", icon: Icons.phone,prefixText: '+91 ',),
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
                    Text("Phone number must be 10 digits",
                        style: TextStyle(color: Colors.red)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade500,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: isSendingOtp ? null : () {
                      if (!validateInputs()) return;
                      sendOtp();
                    },
                    child: isSendingOtp
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Next", style: TextStyle(fontSize: 22, color: Colors.white)),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(color: Colors.grey[600],fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 20,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
