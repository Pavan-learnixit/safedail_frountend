import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DefaultSmsPage extends StatelessWidget {
  const DefaultSmsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // background img
          Positioned.fill(
            child: Image.asset('assets/sms_preview.jpg', fit: BoxFit.cover),
          ),

          //  Bottom card
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
              decoration: BoxDecoration(
                color: isDark ? Colors.black : Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Set default SMS app to get\nspam protection and more for free:',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),

                    const SizedBox(height: 20),

                    _feature(
                      Icons.verified_user,
                      'See legitimate business names & pictures',
                    ),
                    _feature(
                      Icons.filter_alt,
                      'Filter spam and other message categories',
                    ),
                    _feature(
                      Icons.visibility,
                      'View important information at a glance',
                    ),
                    _feature(
                      Icons.lightbulb,
                      'Get quick intuitive actions in your inbox',
                    ),

                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[900] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.verified_user, color: Colors.blue),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'All information is stored locally on your device',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: 200.ms),

                    const SizedBox(height: 20),

                    // no navigation as of nw
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Set default SMS app tapped!'),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Set default SMS app',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ).animate().fadeIn(delay: 300.ms),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _feature(IconData icon, String text) {
    return ListTile(
      dense: true,
      visualDensity: VisualDensity.compact,
      leading: Icon(icon, color: Colors.blue),
      title: Text(text, style: const TextStyle(fontSize: 14)),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.2);
  }
}