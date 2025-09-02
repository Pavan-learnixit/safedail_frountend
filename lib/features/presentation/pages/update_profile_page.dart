import 'package:flutter/material.dart';
import 'package:truecaller_clone/features/api/api_service.dart';
import 'package:truecaller_clone/models/profile.dart';

class UpdateProfilePage extends StatefulWidget {
  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String responseMsg = "";

  void updateProfile() async {
    final profile = Profile(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
    );

    final result = await ApiService.updateProfile(profile);
    setState(() {
      responseMsg = result['message'] ?? 'Profile updated';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name")),
            TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email")),
            TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: "Phone")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: updateProfile, child: Text("Update")),
            SizedBox(height: 20),
            Text(responseMsg),
          ],
        ),
      ),
    );
  }
}
