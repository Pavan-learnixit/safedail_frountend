import 'package:flutter/material.dart';
import 'package:truecaller_clone/features/presentation/pages/premium_screen.dart';
import 'package:truecaller_clone/features/presentation/pages/profile_module_screen.dart';
import 'package:truecaller_clone/features/presentation/pages/settings_screen.dart';
import 'package:truecaller_clone/features/presentation/pages/update_profile_page.dart';
import 'package:truecaller_clone/features/presentation/pages/who_searched_me_screen.dart';
import 'package:truecaller_clone/features/presentation/pages/who_viewed_me_screen.dart';
import 'calls_screen.dart';
import 'connect_withus_screen.dart';
import 'fraud_insurance_screen.dart';
import 'help_screen.dart';
import 'invite_friends_screen.dart';
import 'manage_blockings_screen.dart';
import 'theme_selection_screen.dart';
import 'GetVerificationScreen.dart';
import 'government_services_screen.dart';

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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => GetVerificationPage()),
                    );
                  },
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PremiumScreen()),
                );
              },
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
          ..._buildFeatureList(context),
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

  List<Widget> _buildFeatureList(BuildContext context) {
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
      ["Connect with us", Icons.support_agent, Colors.teal],
      ["Help", Icons.help_outline, Colors.black87],
    ];

    return features.map((item) {
      final title = item[0] as String;
      final icon = item[1] as IconData;
      final color = item[2] as Color;

      return ListTile(
        leading: Icon(icon, color: color),
        title: Text(title),
        trailing: title == "Who viewed my profile"
            ? Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text('99+',
              style: TextStyle(color: Colors.white, fontSize: 12)),
        )
            : title == "Safedial for Wear OS" ||
            title == "Fraud Insurance" ||
            title == "Community"
            ? Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text("NEW",
              style: TextStyle(fontSize: 10, color: Colors.blue)),
        )
            : null,
        onTap: title == "Change theme"
            ? () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ThemeSelectionScreen()),
        )
            : title == "Safedial for Wear OS"
            ? () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => const PlaceholderPage(
                  title: "Safedial for Wear OS")),
        )
            : title == "Inbox cleaner"
            ? () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => const PlaceholderPage(
                  title: "Inbox cleaner")),
        )
            : title == "Family safety"
            ? () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => const PlaceholderPage(
                  title: "Family safety")),
        )
            : title == "Safedial news"
            ? () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => const PlaceholderPage(
                  title: "Safedial news")),
        )
            : title == "Contact requests"
            ? () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => const PlaceholderPage(
                  title: "Contact requests")),
        )
            : title == "Government Services"
            ? () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const GovernmentServicesScreen()),
        )
            : title == "Invite friends"
            ? () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const InviteFriendsScreen()),
        )
            : title == "Help"
            ? () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const HelpScreen()),
        )
            : title == "Connect with us"
            ? () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ConnectWithUsScreen()),
        )
            : title == "Fraud Insurance"
            ? () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const FraudInsuranceScreen()),
        )
            : title == "Manage blocking"
            ? () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ManageBlockingsScreen()),
        )
            : title == "Who searched for me"
            ? () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const WhoSearchedMeScreen()),
        )
            : title == "Who viewed my profile"
            ? () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const WhoViewedMeScreen()),
        )
            : null,
      );
    }).toList();

  }
}
