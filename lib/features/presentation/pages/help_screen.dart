import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final List<Map<String, String>> faqs = [
    {
      "question": "How do I block spam calls?",
      "answer": "Go to 'Manage blocking' in your profile and enable spam filters."
    },
    {
      "question": "How do I get verified?",
      "answer": "Tap 'Get Verified' in your profile and follow the ID upload steps."
    },
    {
      "question": "How do I change my theme?",
      "answer": "Go to 'Change theme' and select Light, Dark, or System mode."
    },
    {
      "question": "How do I invite friends?",
      "answer": "Use the 'Invite Friends' screen to share your referral link."
    },
  ];

  final String supportEmail = "actual email will go here"; //actual email will here
  final String whatsappNumber = "whatsapp number will go here"; // Replace with real support number
  final TextEditingController searchController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();

  List<Map<String, String>> filteredFaqs = [];

  @override
  void initState() {
    super.initState();
    filteredFaqs = faqs;
    searchController.addListener(_filterFaqs);
  }

  void _filterFaqs() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredFaqs = faqs
          .where((faq) =>
      faq["question"]!.toLowerCase().contains(query) ||
          faq["answer"]!.toLowerCase().contains(query))
          .toList();
    });
  }

  Future<void> _launchEmail() async {
    final Uri emailUri =
    Uri(scheme: 'mailto', path: supportEmail, query: 'subject=App Support');
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      _showError("Could not open email app");
    }
  }

  Future<void> _launchWhatsApp() async {
    final Uri whatsappUri =
    Uri.parse("https://wa.me/$whatsappNumber?text=Hi, I need help with the app");
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      _showError("Could not open WhatsApp");
    }
  }

  void _submitFeedback() {
    final feedback = feedbackController.text.trim();
    if (feedback.isEmpty) {
      _showError("Please enter your feedback before submitting.");
      return;
    }

    // Simulate feedback submission
    feedbackController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Thanks for your feedback!")),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text("Search FAQs",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: "Type your question...",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 16),
          ...filteredFaqs.map((faq) => ExpansionTile(
            title: Text(faq["question"]!,
                style: const TextStyle(fontSize: 16)),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                child: Text(faq["answer"]!,
                    style: const TextStyle(fontSize: 14)),
              )
            ],
          )),
          const SizedBox(height: 32),
          const Divider(),
          const Text("Need more help?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: _launchEmail,
            icon: const Icon(Icons.email),
            label: const Text("Contact via Email"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: _launchWhatsApp,
            icon: const Icon(Icons.chat),
            label: const Text("Chat on WhatsApp"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
            ),
          ),
          const SizedBox(height: 32),
          const Divider(),
          const Text("Send Feedback",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: feedbackController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: "Write your feedback here...",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: _submitFeedback,
            icon: const Icon(Icons.send),
            label: const Text("Submit"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
            ),
          ),
        ],
      ),
    );
  }
}
