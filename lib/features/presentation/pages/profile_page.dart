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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: theme.colorScheme.onSurface),
        title: Text(
          'Pavan Umarani',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SettingsScreen()),
                );
              },
              icon: Icon(Icons.settings, color: theme.colorScheme.onSurface),
            ),
          )
        ],
      ),
      backgroundColor: theme.colorScheme.background,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Center(
            child: Text(
              '081231 83143',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onBackground.withOpacity(0.7),
              ),
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
                    backgroundColor: theme.colorScheme.outline.withOpacity(0.3),
                    valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
                  ),
                ),
                Icon(Icons.add_a_photo,
                    color: theme.colorScheme.primary, size: 40),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              '📷 Add profile picture to get 100%',
              style: theme.textTheme.bodySmall,
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
                          builder: (_) => const UpdateProfilePage()),
                    );
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text("Edit profile"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: theme.colorScheme.onSurface,
                  ),
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
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                  ),
                ),
              )
            ],
          ),

          const SizedBox(height: 16),

          // Upgrade to premium
          Card(
            child: ListTile(
              leading: Icon(Icons.workspace_premium,
                  color: theme.colorScheme.secondary),
              title: Text('Upgrade to Premium',
                  style: theme.textTheme.bodyMedium),
              trailing: Icon(Icons.arrow_forward_ios,
                  size: 16, color: theme.colorScheme.onSurface),
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
                    children: [
                      Text('Last 30 days',
                          style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold)),
                      const Spacer(),
                      Icon(Icons.share, color: theme.colorScheme.onSurface),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    spacing: 32,
                    runSpacing: 16,
                    children: [
                      _buildStatItem(theme, Icons.shield, "14", "Spam calls"),
                      _buildStatItem(
                          theme, Icons.access_time, "6m 51s", "Time saved"),
                      _buildStatItem(
                          theme, Icons.search, "224", "Unknown calls"),
                      _buildStatItem(
                          theme, Icons.message, "65", "Messages spam"),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          const Divider(),
          ..._buildFeatureList(context, theme),
        ],
      ),
    );
  }

  Widget _buildStatItem(
      ThemeData theme, IconData icon, String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: theme.colorScheme.primary),
        const SizedBox(height: 4),
        Text(value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            )),
        Text(label,
            textAlign: TextAlign.center, style: theme.textTheme.bodySmall),
      ],
    );
  }

  List<Widget> _buildFeatureList(BuildContext context, ThemeData theme) {
    final features = [
      ["Manage blocking", Icons.block, theme.colorScheme.error],
      ["Safedial for Wear OS", Icons.watch, theme.colorScheme.primary],
      ["Inbox cleaner", Icons.cleaning_services, theme.colorScheme.primary],
      ["Fraud Insurance", Icons.verified_user, theme.colorScheme.primary],
      ["Who viewed my profile", Icons.remove_red_eye, theme.colorScheme.secondary],
      ["Who searched for me", Icons.person_search, theme.colorScheme.secondary],
      ["Contact requests", Icons.contact_page, theme.colorScheme.primary],
      ["Change theme", Icons.palette, theme.colorScheme.onSurface],
      ["Government Services", Icons.account_balance, theme.colorScheme.onSurface],
      ["Family safety", Icons.spa, theme.colorScheme.primary],
      ["Community", Icons.handshake, theme.colorScheme.onSurface],
      ["Invite friends", Icons.send, theme.colorScheme.onSurface],
      ["Safedial news", Icons.book, theme.colorScheme.onSurface],
      ["Connect with us", Icons.support_agent, theme.colorScheme.primary],
      ["Help", Icons.help_outline, theme.colorScheme.onSurface],
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
