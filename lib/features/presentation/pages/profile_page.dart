import 'package:flutter/material.dart';
import 'package:truecaller_clone/features/presentation/pages/settings_screen.dart';
import 'package:truecaller_clone/features/presentation/pages/update_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Pavan Umarani',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 16),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SettingsScreen()));
                  },
                  icon: Icon(
                    Icons.settings,
                    color: Colors.black,
                  ))
              //Icon(Icons.settings, color: Colors.black),
              )
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const Center(
            child: Text(
              '081231 83143',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 20),

          // Circular progress
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    value: 0.8,
                    strokeWidth: 6,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: const AlwaysStoppedAnimation(Colors.blue),
                  ),
                ),
                const Icon(Icons.add_a_photo,
                    color: Colors.blue, size: 40), // Placeholder image
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Center(
            child: Text(
              '📷 Add profile picture to get 100%',
              style: TextStyle(fontSize: 14),
            ),
          ),
          const SizedBox(height: 16),

          // Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const UpdateProfilePage()));
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text("Edit profile"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.verified_user_outlined),
                  label: const Text("Get verified"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
              )
            ],
          ),

          const SizedBox(height: 16),

          // Upgrade to premium
          Card(
            child: ListTile(
              leading:
                  const Icon(Icons.workspace_premium, color: Colors.orange),
              title: const Text('Upgrade to Premium'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          ),

          const SizedBox(height: 16),

          // Last 30 days stats
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text('Last 30 days',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Spacer(),
                      Icon(Icons.share),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    spacing: 32,
                    runSpacing: 16,
                    children: [
                      _buildStatItem(Icons.shield, "14", "Spam calls"),
                      _buildStatItem(Icons.access_time, "6m 51s", "Time saved"),
                      _buildStatItem(Icons.search, "224", "Unknown calls"),
                      _buildStatItem(Icons.message, "65", "Messages spam"),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Feature List
          const Divider(),
          ..._buildFeatureList(),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(label,
            textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  List<Widget> _buildFeatureList() {
    final features = [
      ["Manage blocking", Icons.block, Colors.red],
      ["Safedial for Wear OS", Icons.watch, Colors.green],
      ["Inbox cleaner", Icons.cleaning_services, Colors.green],
      ["Fraud Insurance", Icons.verified_user, Colors.blue],
      ["Who viewed my profile", Icons.remove_red_eye, Colors.orange],
      ["Who searched for me", Icons.person_search, Colors.purple],
      ["Contact requests", Icons.contact_page, Colors.blue],
      ["Change theme", Icons.palette, Colors.grey],
      ["Government Services", Icons.account_balance, Colors.black87],
      ["Family safety", Icons.spa, Colors.green],
      ["Community", Icons.handshake, Colors.black87],
      ["Invite friends", Icons.send, Colors.black87],
      ["Safedial news", Icons.book, Colors.black87],
      ["Help", Icons.help_outline, Colors.black87],
    ];

    return features
        .map((item) => ListTile(
              leading: Icon(item[1] as IconData, color: item[2] as Color),
              title: Text(item[0] as String),
              trailing: item[0] == "Who viewed my profile"
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text('99+',
                          style: TextStyle(color: Colors.white, fontSize: 12)),
                    )
                  : item[0] == "Safedial for Wear OS" ||
                          item[0] == "Fraud Insurance" ||
                          item[0] == "Community"
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text("NEW",
                              style:
                                  TextStyle(fontSize: 10, color: Colors.blue)),
                        )
                      : null,
            ))
        .toList();
  }
}
