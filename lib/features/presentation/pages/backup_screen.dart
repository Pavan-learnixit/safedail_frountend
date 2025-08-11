import 'package:flutter/material.dart';
import 'package:truecaller_clone/features/presentation/pages/upgrade_to_premium_screen.dart';

class BackupScreen extends StatelessWidget {
  const BackupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
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
                        'assets/drive.png', // 🔵 Google Drive logo
                        height: 60,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Image.asset(
                        'assets/call.png', // 🔵 Phone logo
                        height: 60,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                const Text(
                  'Backup available',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Restore settings, call history, contacts, messages,\nmedia, block list and call recordings, to continue\nwhere you left off.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 6, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Backup found (01/07/2025, 11:53)',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Restore',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>PremiumScreen()), (Route<dynamic> route)=> false );


                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
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