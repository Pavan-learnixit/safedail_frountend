import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:truecaller_clone/sms_service.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  List<Map<String, String>> smsMessages = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    askSmsPermission().then((_) {
      loadSmsMessages();
    });
  }

  //  Ask for SMS permission
  Future<void> askSmsPermission() async {
    var status = await Permission.sms.status;
    if (!status.isGranted) {
      await Permission.sms.request();
    }
  }

  //  Fetch SMS messages from Java
  Future<void> loadSmsMessages() async {
    try {
      final messages = await SmsService.getSmsMessages();
      setState(() {
        smsMessages = [
          {
            "address": "Airtel",
            "body": "Your recharge was successful."
          },
          {
            "address": "HDFC",
            "body": "₹500 debited from your account."
          },
          {
            "address": "Flipkart",
            "body": "Your order is out for delivery!"
          }
        ];
        isLoading = false;
      });
    } catch (e) {
      print("Error loading SMS: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Messages")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : smsMessages.isEmpty
          ? const Center(child: Text("No messages found."))
          : ListView.builder(
        itemCount: smsMessages.length,
        itemBuilder: (context, index) {
          final sms = smsMessages[index];
          final sender = sms['address'] ?? 'Unknown';
          final message = sms['body'] ?? '';

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(
                  sender.isNotEmpty ? sender[0].toUpperCase() : '?',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(sender, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                message,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        },
      ),
    );
  }
}
