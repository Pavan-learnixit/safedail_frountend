import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final List<SettingItem> settings = [
    SettingItem(Icons.settings, 'General'),
    SettingItem(Icons.call, 'Calls'),
    SettingItem(Icons.message, 'Messaging'),
    SettingItem(Icons.auto_awesome, 'Assistant'),
    SettingItem(Icons.lock, 'Privacy Center'),
    SettingItem(Icons.shield, 'Block'),
    SettingItem(Icons.watch, 'Safedial for Wear OS'),
    SettingItem(Icons.info_outline, 'About Safedial'),
    SettingItem(Icons.help_outline, 'Help'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        children: [
          _buildProfileHeader(),
          const Divider(),
          ...settings.map((item) => ListTile(
                leading: Icon(item.icon, color: Colors.black87),
                title: Text(item.title),
                onTap: () {}, // Add action here
              )),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue.shade100,
            child: Icon(Icons.camera_alt, size: 30, color: Colors.blue),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pavan Umarani',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4),
                Text(
                  'Manage your profile',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '99+',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}

class SettingItem {
  final IconData icon;
  final String title;

  SettingItem(this.icon, this.title);
}
