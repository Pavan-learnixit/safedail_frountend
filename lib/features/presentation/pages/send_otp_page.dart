import 'package:flutter/material.dart';
import 'package:truecaller_clone/features/api/api_service.dart';

class SendOtpPage extends StatefulWidget {
  @override
  _SendOtpPageState createState() => _SendOtpPageState();
}

class _SendOtpPageState extends State<SendOtpPage> {
  final TextEditingController phoneController = TextEditingController();
  String responseMsg = "";

  void sendOtp() async {
    final result = await ApiService.sendOtp(phoneController.text);
    setState(() {
      responseMsg = result['message'] ?? 'No response';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Send OTP")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: "Enter Phone"),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: sendOtp, child: Text("Send OTP")),
            SizedBox(height: 20),
            Text(responseMsg),
          ],
        ),
      ),
    );
  }
}
