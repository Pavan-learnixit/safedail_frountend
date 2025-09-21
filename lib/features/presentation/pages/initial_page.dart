import 'dart:io';

// import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:truecaller_clone/features/presentation/pages/language_screen.dart';
import 'package:truecaller_clone/platform_channel.dart';

import '../../../core/l10/app_localizations.dart';
import '../utilities/colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/permission_popup.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.safeDial,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  AppLocalizations.of(context)!.knowText,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 10,
                      width: 40,
                      decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 10,
                      width: 40,
                      decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 10,
                      width: 40,
                      decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ],
                ),
                const Placeholder(
                  fallbackHeight: 200,
                  fallbackWidth: 10,
                ),
                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => LanguageScreen()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.language,
                        color: Colors.blue.shade900,
                        size: 30,
                      ),
                      Text(
                        AppLocalizations.of(context)!.changeLanguage,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                                color: Colors.blue.shade900,
                                fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                customButton(
                    onPressed: () async {
                      await _requestPermissions();
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        CallPlatformChannel.startCallService();
                        CallPlatformChannel.requestDialerRole();
                      });

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => PermissionPopupStep1()),
                          (Route<dynamic> route) => false);
                    },
                    label: AppLocalizations.of(context)!.getStarted,
                    width: MediaQuery.sizeOf(context).width,
                    height: 60,
                    isLoading: false,
                    backgroundColor: CustomColors.buttonColor,
                    //Colors.green,
                    borderRadius: 16,
                    textColor: Colors.white,
                    fontSize: 20
                    // border: Border.all(color: Colors.deepPurple)
                    ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  AppLocalizations.of(context)!.privacyText,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.grey, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _requestPermissions() async {
    final statuses = await [
      Permission.phone,
      Permission.contacts,
      Permission.systemAlertWindow,
      Permission.notification,
      // if (Platform.isAndroid &&
      //     await DeviceInfoPlugin()
      //         .androidInfo
      //         .then((info) => info.version.sdkInt >= 34))
      //   Permission.ignoreBatteryOptimizations,
    ].request();

    if (statuses.values.any((status) => status.isPermanentlyDenied)) {
      await openAppSettings();
    }
  }
}
