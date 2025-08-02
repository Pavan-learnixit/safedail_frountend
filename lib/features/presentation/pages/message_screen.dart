import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:truecaller_clone/sms_service.dart';
import 'package:intl/intl.dart';


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
        smsMessages = messages;

        isLoading = false;
      });
    } catch (e) {
      print("Error loading SMS: $e");
      setState(() {
        isLoading = false;
      });
    }
  }
  String _formatSmsDate(String? timestampStr) {
    if (timestampStr == null) return 'Unknown date';
    try {
      final timestamp = int.parse(timestampStr);
      final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
    } catch (e) {
      return 'Invalid date';
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
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatSmsDate(sms['date']),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),

            ),
          );
        },
      ),
    );
  }
}
