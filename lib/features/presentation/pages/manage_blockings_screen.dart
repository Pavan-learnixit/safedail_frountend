import 'package:flutter/material.dart';

class ManageBlockingsScreen extends StatefulWidget {
  const ManageBlockingsScreen({Key? key}) : super(key: key);

  @override
  _ManageBlockingsScreenState createState() => _ManageBlockingsScreenState();
}

class _ManageBlockingsScreenState extends State<ManageBlockingsScreen> {
  List<Map<String,String>> blocked = [
    {"name":"Spammer 1","reason":"Spam calls"},
    {"name":"Telemarketer","reason":"Unwanted calls"},
    {"name":"Scam Bot","reason":"Suspicious activities"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage blockings')),
      body: ListView.separated(
        padding: EdgeInsets.all(12),
        itemCount: blocked.length,
        separatorBuilder: (_, __) => SizedBox(height: 8),
        itemBuilder: (context, index) {
          final item = blocked[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(child: Text(item['name']![0])),
              title: Text(item['name']!),
              subtitle: Text(item['reason']!),
              trailing: TextButton(
                child: Text('Unblock'),
                onPressed: () {
                  setState(() {
                    blocked.removeAt(index);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User unblocked')));
                },
              ),
            ),
          );
        },
      ),
    );
  }
}