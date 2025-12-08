import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallScreenBottomBar extends StatelessWidget {
  final bool showBottomBar;
  final ThemeData theme;

  const CallScreenBottomBar({
    super.key,
    required this.showBottomBar,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: showBottomBar
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        const telNumber = "";
                        final Uri dialUri = Uri(scheme: 'tel', path: telNumber);

                        if (await canLaunchUrl(dialUri)) {
                          await launchUrl(dialUri);
                        } else {
                          throw 'Could not launch dialer';
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                        backgroundColor: theme.colorScheme.primary,
                      ),
                      child: const Icon(Icons.dialpad,
                          size: 28, color: Colors.white),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Call action
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                        backgroundColor: theme.colorScheme.primary,
                      ),
                      child:
                          const Icon(Icons.call, size: 28, color: Colors.white),
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
