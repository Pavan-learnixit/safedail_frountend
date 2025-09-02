import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:truecaller_clone/features/api/api_service.dart';
import 'package:truecaller_clone/models/contact.dart';

class SyncContactsPage extends StatefulWidget {
  @override
  _SyncContactsPageState createState() => _SyncContactsPageState();
}

class _SyncContactsPageState extends State<SyncContactsPage> {
  String responseMsg = "";

  void syncContacts() async {
    if (await FlutterContacts.requestPermission()) {
      final contacts = await FlutterContacts.getContacts(withProperties: true);

      final contactList = contacts.map((c) {
        return ContactModel(
          name: c.displayName,
          phone: c.phones.isNotEmpty ? c.phones.first.number : "",
        ).toJson();
      }).toList();

      final result = await ApiService.syncContacts(contactList);
      setState(() {
        responseMsg = result['message'] ?? 'Contacts synced';
      });
    } else {
      setState(() {
        responseMsg = "Permission denied";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sync Contacts")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
                onPressed: syncContacts, child: Text("Sync Contacts")),
            SizedBox(height: 20),
            Text(responseMsg),
          ],
        ),
      ),
    );
  }
}
