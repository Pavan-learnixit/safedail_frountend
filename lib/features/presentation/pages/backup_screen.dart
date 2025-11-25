import 'package:flutter/material.dart';
import 'package:truecaller_clone/features/presentation/pages/upgrade_to_premium_screen.dart';

class BackupScreen extends StatelessWidget {
  const BackupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Drive + Call Icons
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/drive_arrow.png',
                      height: 160,
                    ),
                    Positioned(
                      top: 0,
                      child: Image.asset(
                        'assets/drive.png',
                        height: 60,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Image.asset(
                        'assets/call.png',
                        height: 60,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                Text(
                  'Backup available',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Restore settings, call history, contacts, messages,\nmedia, block list and call recordings, to continue\nwhere you left off.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Backup found (01/07/2025, 11:53)',
                    style: theme.textTheme.bodySmall,
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Restore',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const PremiumScreen()),
                          (Route<dynamic> route) => false,
                    );
                  },
                  child: Text(
                    'Skip',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
