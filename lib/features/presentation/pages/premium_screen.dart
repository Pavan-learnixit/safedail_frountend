import 'package:flutter/material.dart';
import 'package:truecaller_clone/features/presentation/pages/premium_listtiles.dart';
import 'package:truecaller_clone/features/presentation/pages/premium_screen2.dart';
import 'premium_promocard.dart';



class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Choose a Plan",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              PremiumPromoCard(),
              SizedBox(height: 15),
              Center(
                child: Text(
                  "Discover features and compare plans",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              PremiumScreen2(),
              SizedBox(height: 7),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Upgrade Now",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 7),
              PremiumListTiles(),
            ],
          ),
        ),
      ),
    );
  }
}


