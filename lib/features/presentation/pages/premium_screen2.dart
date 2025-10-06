import 'package:flutter/material.dart';

class PremiumScreen2 extends StatelessWidget {
  PremiumScreen2({super.key});
  final ScrollController _scrollController = ScrollController();
  final GlobalKey sectionKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return SafeArea(
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.keyboard_arrow_down, color: colorScheme.onBackground),
              onPressed: () {
                Scrollable.ensureVisible(
                  sectionKey.currentContext!,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
            ),
            Container(
              key: sectionKey,
              height: 150,
              width: MediaQuery.of(context).size.width * 0.85,
              margin: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.block, color: colorScheme.primary),
                        SizedBox(width: 8),
                        Text(
                          "No Ads",
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Enjoy Safedail without any ads",
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.check_circle, color: Colors.green),
                            Text("Premium", style: textTheme.bodySmall),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.check_circle, color: Colors.green),
                            Text("Family", style: textTheme.bodySmall),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
