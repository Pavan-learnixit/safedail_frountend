import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageDetailScreen extends StatelessWidget {
  final Map<String, String> sms;

  const MessageDetailScreen({super.key, required this.sms});

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
    final sender=sms['address'] ?? 'Unkown';
    final message = sms['body'] ?? '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                sender.isNotEmpty ? sender[0].toUpperCase() : '?',
                style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold), ), ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sender, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18), ),
                Text( _formatSmsDate(sms['date']), style: const TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Date/time centered at top
            Text(
              _formatSmsDate(sms['date']),
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 20),

            // Message bubble
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blueAccent.withOpacity(0.3)),
                ),
                child: Text(
                  message,
                  style: const TextStyle(fontSize: 16, height: 1.4,color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),

      // Buttons pinned at bottom
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                // reply action
              },
              icon: const Icon(Icons.reply),
              label: const Text("Reply", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // delete action
                Navigator.pop(context);
              },
              icon: const Icon(Icons.delete),
              label: const Text("Delete", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade300,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
