import 'package:flutter/material.dart';

class PremiumListTiles extends StatelessWidget {
  PremiumListTiles({super.key});

  final List<String> features = [
    "Advanced Spam Blocking",
    "Verification Badge",
    "Fraud Insurance*",
    "Call Recording",
    "Truecaller Assistant",
    "Who Viewed My Profile",
    "Who Searched For Me",
    "Contact Requests",
    "Incognito Mode",
    "Family Sharing (up to 4 accounts)",
    "Ghost Call",
    "Premium Badge",
    "Live Chat Support"
  ];

  final List<IconData> featureIcons = [
    Icons.block,
    Icons.verified,
    Icons.security,
    Icons.mic,
    Icons.record_voice_over,
    Icons.visibility,
    Icons.search,
    Icons.contact_mail,
    Icons.visibility_off,
    Icons.group,
    Icons.call,
    Icons.star,
    Icons.chat,
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: features.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  color: colorScheme.surface,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: Icon(featureIcons[index], color: colorScheme.primary),
                    title: Text(
                      features[index],
                      style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right, color: colorScheme.onSurface),
                    onTap: () {
                      // Show more details or upgrade action
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
