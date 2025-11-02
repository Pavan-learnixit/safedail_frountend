import 'package:flutter/material.dart';

class AboutSafedialScreen extends StatelessWidget {
  const AboutSafedialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_SettingsItem> items = [
      _SettingsItem(
        title: 'About Safedial',
        description: 'Safedial is a privacy-first communication app built to protect your identity and data.',
        icon: Icons.lock_outline,
      ),
      _SettingsItem(
        title: 'Version',
        description: '1.0.0 (Build 42)',
        icon: Icons.info_outline,
      ),
      _SettingsItem(
        title: 'Contact Us',
        description: 'support@safedial.app',
        icon: Icons.email_outlined,
      ),
      _SettingsItem(
        title: 'Privacy Policy',
        description: 'Read how we handle your data and protect your privacy.',
        icon: Icons.shield_outlined,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('About Safedial')),
      body: ListView.separated(
        itemCount: items.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) => _SettingsTile(item: items[index]),
      ),
    );
  }
}

class _SettingsItem {
  final String title;
  final String description;
  final IconData icon;

  const _SettingsItem({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class _SettingsTile extends StatelessWidget {
  final _SettingsItem item;

  const _SettingsTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(item.icon, color: Theme.of(context).colorScheme.primary),
      title: Text(item.title, style: Theme.of(context).textTheme.titleMedium),
      subtitle: Text(item.description),
    );
  }
}
