import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GovernmentServicesScreen extends StatelessWidget {
  const GovernmentServicesScreen({super.key});

  final List<Map<String, dynamic>> services = const [
    {
      "label": "Aadhaar Services",
      "icon": Icons.perm_identity,
      "url": "https://uidai.gov.in"
    },
    {
      "label": "PAN Card Services",
      "icon": Icons.credit_card,
      "url": "https://www.onlineservices.nsdl.com"
    },
    {
      "label": "Passport Info",
      "icon": Icons.travel_explore,
      "url": "https://www.passportindia.gov.in"
    },
    {
      "label": "Voter ID Lookup",
      "icon": Icons.how_to_vote,
      "url": "https://voterportal.eci.gov.in"
    },
    {
      "label": "Income Tax Portal",
      "icon": Icons.attach_money,
      "url": "https://www.incometax.gov.in"
    },
    {
      "label": "Digital Locker",
      "icon": Icons.lock,
      "url": "https://www.digilocker.gov.in"
    },
    {
      "label": "e-Governance Helpdesk",
      "icon": Icons.support_agent,
      "url": "https://www.nielit.gov.in"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Government Services',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: services.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final item = services[index];
          return ListTile(
            leading: Icon(item["icon"], color: Colors.blue),
            title: Text(item["label"],
                style: const TextStyle(fontSize: 18)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () async {
              final url = Uri.parse(item["url"]);
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Could not launch ${item["url"]}')),
                );
              }
            },
          );
        },
      ),
    );
  }
}
