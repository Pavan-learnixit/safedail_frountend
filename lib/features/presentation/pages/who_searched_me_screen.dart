import 'package:flutter/material.dart';

class WhoSearchedMeScreen extends StatelessWidget {
  const WhoSearchedMeScreen({Key? key}) : super(key: key);

  final List<Map<String,String>> demo = const [
    {"name":"Unknown Caller","time":"10 mins ago","subtitle":"Searched by number"},
    {"name":"Ankit Verma","time":"4 hours ago","subtitle":"Searched from suggestions"},
    {"name":"Sneha Rao","time":"Yesterday","subtitle":"Searched by name"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Who searched for me')),
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