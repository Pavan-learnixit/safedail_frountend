import 'package:flutter/material.dart';
// import 'package:truecaller_clone/core/l10/app_localizations.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:truecaller_clone/features/presentation/pages/initial_page.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../main.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final List<Map<String, dynamic>> languages = [
    {
      'code': 'hi',
      'label': 'हिंदी',
      'symbol': 'ह',
      'color': Colors.orangeAccent
    },
    {
      'code': 'en',
      'label': 'English',
      'symbol': 'E',
      'color': Colors.blue.shade300
    },
    {
      'code': 'bn',
      'label': 'বাংলা',
      'symbol': 'বা',
      'color': Colors.teal.shade200
    },
    {
      'code': 'te',
      'label': 'తెలుగు',
      'symbol': 'తె',
      'color': Colors.red.shade200
    },
    {
      'code': 'mr',
      'label': 'मराठी',
      'symbol': 'म',
      'color': Colors.indigo.shade200
    },
    {
      'code': 'ta',
      'label': 'தமிழ்',
      'symbol': 'த',
      'color': Colors.cyan.shade300
    },
    {
      'code': 'kn',
      'label': 'ಕನ್ನಡ',
      'symbol': 'ಕ',
      'color': Colors.green.shade300
    },
    {
      'code': 'gu',
      'label': 'ગુજરાતી',
      'symbol': 'ગુ',
      'color': Colors.purple.shade200
    },
    {
      'code': 'pa',
      'label': 'ਪੰਜਾਬੀ',
      'symbol': 'ਪੰ',
      'color': Colors.blueAccent.shade100
    },
    {
      'code': 'ml',
      'label': 'മലയാളം',
      'symbol': 'മ',
      'color': Colors.lightGreen.shade200
    },
    {
      'code': 'ur',
      'label': 'اردو',
      'symbol': 'ا',
      'color': Colors.orange.shade100
    },
  ];

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.safeDial,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                AppLocalizations.of(context)!.welcomeText,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Colors.black, fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                AppLocalizations.of(context)!.pickYourLang,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.grey, fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 20,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     _container(100, 200, localization.english,""),
              //     _container(100, 200, localization.hindi,""),
              //   ],
              // ),
              // Wrap(
              //   spacing: 12,
              //   runSpacing: 12,
              //   children: languages.map((lang) {
              //     return _languageCard(lang['symbol']!, lang['label']!, lang['code']!);
              //   }).toList(),
              // ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 2,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: languages.map((lang) {
                    return _languageCard(
                      lang['symbol'],
                      lang['label'],
                      lang['code'],
                      lang['color'],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _languageCard(String symbol, String name, String code, Color color) {
    return InkWell(
      onTap: () {
        MyApp.setLocale(context, Locale(code));
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => InitialPage()));
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 76,
              decoration: BoxDecoration(
                color: color.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                symbol,
                style: TextStyle(
                    fontSize: 42, fontWeight: FontWeight.bold, color: color),
              ),
            ),
            const SizedBox(width: 10),
            Center(
              child: Text(
                name,
                style: const TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
