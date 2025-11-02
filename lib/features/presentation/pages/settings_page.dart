import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Call Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            value: true,
            onChanged: (_) {},
            title: const Text('Filter blocked numbers automatically'),
            subtitle: const Text('Block calls from known spam numbers'),
          ),
          ListTile(
            title: const Text('Manage blocked numbers'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Sync with server (placeholder)'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
