import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:truecaller_clone/features/presentation/pages/language_screen.dart';
import 'core/l10/app_localizations.dart';
import 'features/presentation/bloc/theme_bloc.dart';
import 'features/presentation/bloc/user_bloc.dart';
import 'injection.config.dart';
import 'injection.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  await _requestPermissions();
  runApp(const MyApp());
}

Future<void> _requestPermissions() async {
  // final deviceInfo = DeviceInfoPlugin();
  // final androidInfo = await deviceInfo.androidInfo;
  // final isAndroid15OrNewer = androidInfo.version.sdkInt >= 34;
  final statuses = await [
    // Permission.phone,
    // Permission.contacts,

    Permission.systemAlertWindow,
    // Permission.notification,

    // if (Platform.isAndroid &&
    //     await DeviceInfoPlugin()
    //         .androidInfo
    //         .then((info) => info.version.sdkInt >= 34))
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(create: (_) => getIt<UserBloc>()),
        BlocProvider<ThemeBloc>(create: (_) => ThemeBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Truecaller Clone',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.light,
              ),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
            ),
            themeMode: themeState.themeMode, // controlled by your ThemeBloc
            home: const LanguageScreen(),
            locale: _locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          );

        },
      ),
    );
  }

}
