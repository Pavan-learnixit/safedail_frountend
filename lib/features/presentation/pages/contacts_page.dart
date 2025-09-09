// import 'package:flutter/material.dart';
// import 'package:flutter_contacts/flutter_contacts.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class ContactsPage extends StatefulWidget {
//   const ContactsPage({Key? key}) : super(key: key);
//
//   @override
//   State<ContactsPage> createState() => _ContactsPageState();
// }
//
// class _ContactsPageState extends State<ContactsPage> {
//   List<Contact> _contacts = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchContacts();
//   }
//
//   Future<void> _fetchContacts() async {
//     if (await Permission.contacts.request().isGranted) {
//       final contacts = await FlutterContacts.getContacts(withProperties: true);
//       setState(() {
//         _contacts = contacts;
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Contacts permission denied")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Contacts")),
//       body: _contacts.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: _contacts.length,
//               itemBuilder: (context, index) {
//                 final contact = _contacts[index];
//                 final phone = contact.phones.isNotEmpty
//                     ? contact.phones.first.number
//                     : "No number";
//
//                 return ListTile(
//                   leading: const CircleAvatar(child: Icon(Icons.person)),
//                   title: Text(contact.displayName),
//                   subtitle: Text(phone),
//                 );
//               },
//             ),
//     );
//   }
// }
