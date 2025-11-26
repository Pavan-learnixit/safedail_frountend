import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../auth/domain/entities/call_log-model.dart';

class CallLogItem extends StatelessWidget {
  final CallLogModel model;
  final VoidCallback? onTap;

  const CallLogItem({super.key, required this.model, this.onTap});

  @override
  Widget build(BuildContext context) {
    final timeText = DateFormat('hh:mm a').format(model.time);
    final subtitle =
        '${model.number} • ${_durationText(model.durationSeconds)}';

    IconData icon;
    Color iconColor = Colors.grey;
    switch (model.type) {
      case CallType.incoming:
        icon = Icons.call_received;
        iconColor = Colors.green;
        break;
      case CallType.outgoing:
        icon = Icons.call_made;
        iconColor = Colors.blue;
        break;
      case CallType.missed:
        icon = Icons.call_missed;
        iconColor = Colors.red;
        break;
      case CallType.blocked:
        icon = Icons.block;
        iconColor = Colors.orange;
        break;
    }

    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
          child: Text(_initials(model.name)),
          backgroundColor: Colors.blue.shade100),
      title: Row(
        children: [
          Expanded(
              child: Text(model.name,
                  style: const TextStyle(fontWeight: FontWeight.w600))),
          Text(timeText,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
        ],
      ),
      subtitle: Row(
        children: [
          Icon(icon, size: 16, color: iconColor),
          const SizedBox(width: 6),
          Expanded(child: Text(subtitle)),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.info_outline),
        onPressed: () {
          // show details
          showModalBottomSheet(
            context: context,
            builder: (_) => _detailSheet(context),
          );
        },
      ),
    );
  }

  String _initials(String name) {
    if (name.isEmpty) return '?'; // fallback initial
    final parts = name.trim().split(RegExp(r'\s+')); // split on whitespace
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      return parts[0].isNotEmpty ? parts[0][0].toUpperCase() : '?';
    }
    final first = parts[0].isNotEmpty ? parts[0][0] : '';
    final second = parts[1].isNotEmpty ? parts[1][0] : '';
    final initials = '$first$second'.trim();
    return initials.isEmpty ? '?' : initials.toUpperCase();
  }


  String _durationText(int sec) {
    if (sec <= 0) return '0s';
    final m = sec ~/ 60;
    final s = sec % 60;
    if (m > 0) return '${m}m ${s}s';
    return '${s}s';
  }

  Widget _detailSheet(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(model.name,
                style:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Number: ${model.number}'),
            Text('Time: ${model.time}'),
            Text('Duration: ${_durationText(model.durationSeconds)}'),
            Text('Type: ${model.type.name}'),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.call),
                    label: const Text('Call')),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.message),
                    label: const Text('Message')),
              ],
            ),
            const SizedBox(height: 12),
          ]),
    );
  }
}
