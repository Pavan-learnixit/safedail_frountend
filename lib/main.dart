

import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:truecaller_clone/features/presentation/pages/initial_page.dart';
import 'platform_channel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _requestPermissions();
  runApp(const MyApp());
}

Future<void> _requestPermissions() async {
  // final deviceInfo = DeviceInfoPlugin();
  // final androidInfo = await deviceInfo.androidInfo;
  // final isAndroid15OrNewer = androidInfo.version.sdkInt >= 34;
  final statuses = await [
    Permission.phone,
    Permission.contacts,
    // Permission.,
    Permission.systemAlertWindow,
    Permission.notification,
  // await Permission.notification.request();
    if (Platform.isAndroid && await DeviceInfoPlugin().androidInfo.then((info) => info.version.sdkInt >= 34))
      Permission.ignoreBatteryOptimizations,
  ].request();

  // If any permission is permanently denied, open app settings
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
    // Start services when app launches
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CallPlatformChannel.startCallService();
      CallPlatformChannel.requestDialerRole();
    });

    return MaterialApp(
      title: 'Truecaller Clone',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: InitialPage(),
       locale: _locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Truecaller Clone")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Call detection is active"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _requestPermissions();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Permissions refreshed")),
                );
              },
              child: const Text("Check Permissions Again"),
            ),
          ],
        ),
      ),
    );
  }
}