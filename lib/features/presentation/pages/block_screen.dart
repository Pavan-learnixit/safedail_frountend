import 'package:flutter/material.dart';
import 'package:truecaller_clone/features/presentation/pages/premium_screen.dart';

class BlockingScreen extends StatefulWidget {
  const BlockingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BlockingScreenState createState() => _BlockingScreenState();
}

class _BlockingScreenState extends State<BlockingScreen> {
  bool blockVerifiedBusinesses = false;
  bool blockForeignNumbers = false;
  bool blockHiddenNumbers = false;
  bool blockNotInPhonebook = false;
  bool block140Telemarketers = false;
  bool notifyBlockedCalls = true;
  bool notifyBlockedMessages = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Block"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildProtectionLevel(),
          SizedBox(height: 20),
          _buildNotificationSettings(),
          SizedBox(height: 20),
          _buildBlockListSection(),
          SizedBox(height: 20),
          _buildAdvancedBlocking(),
          SizedBox(height: 20),
          _buildPremiumBlockOption(),
        ],
      ),
    );
  }

  Widget _buildProtectionLevel() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red.shade700,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.shield, color: Colors.white, size: 40),
          SizedBox(height: 10),
          Text(
            "Level of protection | Off",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          SizedBox(height: 5),
          Text(
            "Spam callers will be identified but not blocked",
            style: TextStyle(color: Colors.white70),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ["Off", "Basic", "Max"].map((label) {
              return ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                child: Text(label),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Notification settings", style: TextStyle(fontWeight: FontWeight.bold)),
        SwitchListTile(
          title: Text("Notification for blocked calls"),
          value: notifyBlockedCalls,
          onChanged: (val) => setState(() => notifyBlockedCalls = val),
        ),
        SwitchListTile(
          title: Text("Notification for blocked messages"),
          value: notifyBlockedMessages,
          onChanged: (val) => setState(() => notifyBlockedMessages = val),
        ),
      ],
    );
  }

  Widget _buildBlockListSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Add to my block list", style: TextStyle(fontWeight: FontWeight.bold)),
        ListTile(leading: Icon(Icons.call), title: Text("Phone numbers")),
        ListTile(leading: Icon(Icons.person), title: Text("Caller names")),
        ListTile(leading: Icon(Icons.info_outline), title: Text("Sender IDs")),
        ListTile(leading: Icon(Icons.flag), title: Text("Country codes")),
        ListTile(leading: Icon(Icons.format_list_numbered), title: Text("Number series")),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: Text("View all"),
          ),
        )
      ],
    );
  }

  Widget _buildAdvancedBlocking() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Advanced blocking", style: TextStyle(fontWeight: FontWeight.bold)),
        _buildSwitchTile(
          icon: Icons.business,
          title: "Block verified businesses",
          subtitle: "Requires Max protection enabled",
          value: blockVerifiedBusinesses,
          onChanged: (val) => setState(() => blockVerifiedBusinesses = val),
        ),
        _buildSwitchTile(
          icon: Icons.flag,
          title: "Numbers from foreign countries",
          subtitle: "Only numbers from your country will be able to call you",
          value: blockForeignNumbers,
          onChanged: (val) => setState(() => blockForeignNumbers = val),
        ),
        _buildSwitchTile(
          icon: Icons.help_outline,
          title: "Hidden numbers",
          subtitle: "Block any number shown as Unknown or Private",
          value: blockHiddenNumbers,
          onChanged: (val) => setState(() => blockHiddenNumbers = val),
        ),
        _buildSwitchTile(
          icon: Icons.contact_phone,
          title: "Numbers not in phonebook",
          subtitle: "Only people in your phonebook will be able to call you",
          value: blockNotInPhonebook,
          onChanged: (val) => setState(() => blockNotInPhonebook = val),
        ),
      ],
    );
  }

  Widget _buildPremiumBlockOption() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Requires Premium", style: TextStyle(fontWeight: FontWeight.bold)),
          SwitchListTile(
            secondary: Icon(Icons.headset_mic),
            title: Text("Block 140 series telemarketers"),
            subtitle: Text("Block registered Indian telemarketers"),
            value: block140Telemarketers,
            onChanged: (val) => setState(() => block140Telemarketers = val),
          ),
          ElevatedButton.icon(
            icon: Icon(Icons.crop),
            label: Text("Get Premium"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PremiumScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              minimumSize: Size(double.infinity, 48),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      secondary: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
    );
  }
}