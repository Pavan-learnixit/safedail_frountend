import 'package:flutter/material.dart';
import 'package:truecaller_clone/features/presentation/pages/privacy_center_page.dart';
import 'package:truecaller_clone/features/presentation/pages/update_profile_page.dart';
import 'GetVerificationScreen.dart';
import 'about_safedial_screen.dart';
import 'block_screen.dart';
import 'help_screen.dart';
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
    SettingItem(Icons.edit, 'Edit Profile'),
    SettingItem(Icons.verified_user, 'Get Verified'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        backgroundColor: colorScheme.background,
        foregroundColor: colorScheme.onBackground,
        elevation: 0,
      ),
      body: ListView(
        children: [
          _buildProfileHeader(context),
          const Divider(),
          ...settings.map((item) => ListTile(
            leading: Icon(item.icon, color: colorScheme.primary),
            title: Text(
              item.title,
              style: textTheme.bodyLarge,
            ),
            onTap: () {
              switch (item.title) {
                case 'Edit Profile':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const UpdateProfilePage()),
                  );
                  break;
                case 'Get Verified':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const GetVerificationPage()),
                  );
                  break;
                case 'Help':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HelpScreen()),
                  );
                  break;
                case 'Privacy Center':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PrivacyCenterPage()),
                  );
                  break;
                case 'About Safedial':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AboutSafedialScreen()),
                  );
                  break;
                case 'Help':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => HelpScreen()),
                  );
                  break;
                case 'Block':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => BlockingScreen()),
                  );
                  break;
                default:
                  break;
              }
            },
          )),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: colorScheme.primaryContainer,
            child: Icon(Icons.camera_alt, size: 30, color: colorScheme.primary),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pavan Umarani',
                  style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4),
                Text(
                  'Manage your profile',
                  style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '99+',
              style: textTheme.labelLarge?.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
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