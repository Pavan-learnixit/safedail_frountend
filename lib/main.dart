import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:truecaller_clone/core/l10/app_localizations.dart';
import 'package:truecaller_clone/features/presentation/pages/language_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _requestPermissions();
  runApp(const MyApp());
}

Future<void> _requestPermissions() async {
  final statuses = await [
    Permission.systemAlertWindow,
    if (Platform.isAndroid &&
        await DeviceInfoPlugin()
            .androidInfo
            .then((info) => info.version.sdkInt >= 34))
      Permission.ignoreBatteryOptimizations,
  ].request();

  if (statuses.values.any((status) => status.isPermanentlyDenied)) {
    await openAppSettings();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeDial',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LanguageScreen(),
      locale: _locale, // ✅ Locale setter
      localizationsDelegates:
          AppLocalizations.localizationsDelegates, // ✅ Delegates
      supportedLocales:
          AppLocalizations.supportedLocales, // ✅ Supported locales
    );
  }
}
