import 'package:flutter/material.dart';
class premium_listtiles extends StatelessWidget {
  premium_listtiles({super.key});
  List<String> features = [
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
    "ghost call",
    "premium Badge",
    "live Chat Support"
  ];
  List<IconData> featureIcons = [
    Icons.block, // Advanced Spam Blocking
    Icons.verified, // Verification Badge
    Icons.security, // Fraud Insurance*
    Icons.mic, // Call Recording
    Icons.record_voice_over, // Truecaller Assistant
    Icons.visibility, // Who Viewed My Profile
    Icons.search, // Who Searched For Me
    Icons.contact_mail, // Contact Requests
    Icons.visibility_off, // Incognito Mode
    Icons.group, // Family Sharing
    Icons.call, // Ghost Call
    Icons.star, // Premium Badge
    Icons.chat, // Live Chat Support
  ];

  @override
  Widget build(BuildContext context) {
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
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          leading: Icon(featureIcons[index], color: Colors.blueAccent),
                          title: Text(
                            features[index],
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            // Show more details or upgrade action
                          },
                        ),
                      );
                    },
                  ),
                ]
            )
        )
    );
  }
}
