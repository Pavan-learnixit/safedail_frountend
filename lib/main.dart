// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'platform_channel.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await [
//     Permission.phone,
//     Permission.notification,
//   ].request();
//
//   runApp(const MyApp());
// }
//
// Future<void> callApi()async {
//   await CallPlatformChannel.startCallService();
//   await CallPlatformChannel.requestDialerRole();
// }
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//     callApi();
//     return MaterialApp(
//       title: 'Truecaller Clone',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const HomeScreen(),
//     );
//   }
// }
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Truecaller Clone")),
//       body: const Center(child: Text("Listening for calls...")),
//     );
//   }
// }

//
//
//
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// // void main() {
// //   runApp(CallDetectionApp());
// // }
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await [
//     Permission.phone,
//     Permission.notification,
//   ].request();
//
//   runApp( CallDetectionApp());
// }
//
// class CallDetectionApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Truecaller Clone',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: HomeScreen(),
//     );
//   }
// }
//
// class HomeScreen extends StatelessWidget {
//   static const platform = MethodChannel('call_detection_channel');
//
//   Future<void> requestDialerRole() async {
//     try {
//       final result = await platform.invokeMethod('requestDialerRole');
//       debugPrint("Dialer role result: $result");
//       ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
//         SnackBar(content: Text(result.toString())),
//       );
//     } catch (e) {
//       debugPrint("Error requesting dialer role: $e");
//     }
//   }
//
//   Future<void> startCallService() async {
//     try {
//       final result = await platform.invokeMethod('startCallService');
//       debugPrint("Service start result: $result");
//       ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
//         SnackBar(content: Text("Service Started")),
//       );
//     } catch (e) {
//       debugPrint("Error starting service: $e");
//     }
//   }
//
//   final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
//   GlobalKey<ScaffoldMessengerState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return ScaffoldMessenger(
//       key: _scaffoldKey,
//       child: Scaffold(
//         appBar: AppBar(title: const Text('Truecaller Clone')),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: requestDialerRole,
//                 child: const Text('Request Dialer Role'),
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: startCallService,
//                 child: const Text('Start Call Detection Service'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'platform_channel.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   // Request all necessary permissions
//   await requestPhonePermissions();
//
//   runApp(const MyApp());
// }
//
// // Future<void> requestPermissions() async {
// //   // Request phone permissions
// //   final permissions = await [
// //     Permission.phone,
// //     Permission.callPhone,
// //     Permission.contacts,
// //     Permission.manageOwnCalls,
// //     Permission.readPhoneNumbers,
// //     Permission.readPhoneState,
// //     Permission.systemAlertWindow,
// //     Permission.notification,
// //   ].request();
// //
// //   // Log permission statuses for debugging
// //   permissions.forEach((permission, status) {
// //     print('$permission: $status');
// //   });
// // }
// Future<void> requestPhonePermissions() async {
//   // Request all phone-related permissions
//   final statuses = await [
//     Permission.phone,      // Covers most phone operations
//     Permission.contacts,   // For call logs and contacts
//     // Permission.,    // Specifically for call logs (if needed)
//   ].request();
//
//   // For Android-specific permissions
//   if (Platform.isAndroid) {
//     await [
//       Permission.manageExternalStorage, // If you need storage access
//       Permission.systemAlertWindow,      // For overlay windows
//       Permission.notification,           // For notifications
//     ].request();
//   }
//
//   // Check if all permissions are granted
//   final allGranted = statuses.values.every((status) => status.isGranted);
//   if (!allGranted) {
//     // Handle case where permissions are denied
//     openAppSettings(); // Direct user to app settings
//   }
// }
//
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Start services when app launches
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       CallPlatformChannel.startCallService();
//       CallPlatformChannel.requestDialerRole();
//     });
//
//     return MaterialApp(
//       title: 'Truecaller Clone',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const HomeScreen(),
//     );
//   }
// }
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Truecaller Clone")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text("Call detection is active"),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 // Recheck all permissions
//                 await requestPhonePermissions();
//               },
//               child: const Text("Check Permissions Again"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: const HomeScreen(),
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