import 'package:flutter/material.dart';
import '../../../api_service.dart';
import 'verify_otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  bool isLoading = false;
  bool isPhoneValid = false;
  Future<void> _sendOtp() async {
    setState(() => isLoading = true);
    try {
      print("Sending OTP to: ${phoneController.text}");
      final response = await ApiService.sendOtp(phoneController.text).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception("Request timed out"),
      );
      print("Response: ${response.statusCode} ${response.body}");
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("OTP sent successfully")),
        );
        Future.delayed(Duration(milliseconds: 100), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  VerifyOtpScreen(phoneNumber: phoneController.text, isSignupFlow: false,),

            ),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to send OTP: ${response.statusCode}")),
        );
      }
    } catch (e) {
      print("Error during OTP request: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf9f9f9),
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(
            fontSize: 40, // bigger
            fontWeight: FontWeight.w900, // extra bold
            color: Colors.black,
          ),
        ),
        centerTitle: false, // Ensures it's left-aligned
        elevation: 0, // Optional: removes shadow for a flat look
        backgroundColor: Colors.transparent, // Optional: blends with background
        foregroundColor: Colors.black, // Optional: sets text/icon color
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset("assets/images/loginimage.png",
                    width: 200, height: 200),
                const SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Welcome to ",
                        style: TextStyle(
                          fontSize: 28, // slightly smaller
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: "Safe Dial",
                        style: TextStyle(
                          fontSize: 40, // bigger
                          fontWeight: FontWeight.w900, // extra bold
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text("Enter Your Phone Number To Login",
                    style: const TextStyle(fontSize: 17)),
                const SizedBox(height: 24),
                TextField(
                  controller: phoneController,
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                    counterText: "", // hides character counter
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
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
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade500,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: (isLoading || !isPhoneValid) ? null : _sendOtp,
                    child: isLoading
                        ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2),
                    )
                        : const Text(
                      "Send OTP",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
