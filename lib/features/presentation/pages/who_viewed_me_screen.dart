import 'package:flutter/material.dart';

class WhoViewedMeScreen extends StatelessWidget {
  const WhoViewedMeScreen({Key? key}) : super(key: key);

  final List<Map<String,String>> demo = const [
    {"name":"Rahul Sharma","time":"2 hours ago","subtitle":"Viewed from unknown"},
    {"name":"Priya Singh","time":"Yesterday","subtitle":"Viewed from recent search"},
    {"name":"Amit Kumar","time":"3 days ago","subtitle":"Viewed from contact list"},
    {"name":"Neha Patel","time":"1 week ago","subtitle":"Viewed via profile link"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Who viewed my profile')),
      body: ListView.separated(
        padding: EdgeInsets.all(12),
        itemCount: demo.length,
        separatorBuilder: (_, __) => SizedBox(height: 8),
        itemBuilder: (context, index) {
          final item = demo[index];
          return ListTile(
            leading: CircleAvatar(child: Text(item['name']![0])),
            title: Text(item['name']!),
            subtitle: Text(item['subtitle']!),
            trailing: Text(item['time']!),
            onTap: (){},
          );
        },
      ),
    );
  }
}