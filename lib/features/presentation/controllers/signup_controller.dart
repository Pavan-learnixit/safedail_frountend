import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_events.dart';
import '../pages/verify_otp_screen.dart';

class SignupController {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  SignupController({
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
  });

  bool isValidName(String name) {
    final nameRegex = RegExp(r"^[A-Za-z\s'-]+$");
    return nameRegex.hasMatch(name.trim());
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool isValidPhone(String phone) => phone.length == 10;

  bool validateInputs(BuildContext context) {
    final firstName = firstNameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();

    print("First name: '$firstName'");
    print("Email: '$email'");
    print("Phone: '$phone'");

    if (firstName.isEmpty) {
      _showError(context, "First name is required");
      return false;
    }
    if (!isValidName(firstName)) {
      _showError(context, "First name must contain only letters");
      return false;
    }

    if (email.isEmpty || !isValidEmail(email)) {
      _showError(context, "Enter a valid email");
      return false;
    }

    if (phone.isEmpty) {
      _showError(context, "Phone number is required");
      return false;
    }
    if (!isValidPhone(phone)) {
      _showError(context, "Phone number must be 10 digits");
      return false;
    }
    return true;
  }

  void submit(BuildContext context) {
    if (!validateInputs(context)) return;

    final payload = {
      "name": "${firstNameController.text.trim()} ${lastNameController.text.trim()}",
      "email": emailController.text.trim(),
      "phoneNumber": phoneController.text.trim(),
      "password": "dummy-password", // hardcoded or later replaced
    };

    context.read<UserBloc>().add(SendOtpEvent(phoneController.text.trim()));

  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
