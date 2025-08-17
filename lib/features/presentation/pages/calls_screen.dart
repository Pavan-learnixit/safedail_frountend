import 'package:flutter/material.dart';
import 'package:truecaller_clone/features/presentation/pages/profile_page.dart';
import 'package:truecaller_clone/features/presentation/widgets/call_widget.dart';
import 'package:truecaller_clone/features/presentation/widgets/search_bar.dart';

import 'contacts_page.dart';

class CallsScreen extends StatefulWidget {
  const CallsScreen({super.key});

  @override
  State<CallsScreen> createState() => _CallsScreenState();
}

class _CallsScreenState extends State<CallsScreen> {
  TextEditingController searchController = TextEditingController();
  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildSearchBar(
                  controller: searchController,
                  suffixOnPressed: () {},
                  prefixOnPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ProfilePage()));
                  },
                  onSubmitted: (value) {},
                  height: 60),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buttons(
                      icon: Icons.contact_phone,
                      text: "Contacts",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ContactsPage()),
                        );
                      }),
                  _buttons(
                      icon: Icons.favorite,
                      text: "Favorites",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const PlaceholderPage(
                                  title: "Favorites Page")),
                        );
                      }),
                  _buttons(
                      icon: Icons.whatshot,
                      text: "Voice HD",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const PlaceholderPage(
                                  title: "Voice HD Page")),
                        );
                      }),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              if (isEnabled) customCard(),
              if (isEnabled)
                const SizedBox(
                  height: 10,
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  mostCalledWidgets(name: 'Prajwal', char: 'P', label: "7h"),
                  mostCalledWidgets(name: 'Manoj', char: 'M', label: "7h"),
                  mostCalledWidgets(name: 'Raju', char: 'R', label: "7h"),
                  mostCalledWidgets(name: 'Mayank', char: 'M', label: "7h"),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CallWidget(
                char: "P",
                label: "3 min",
                name: "Prekshi",
                time: "8:21 PM",
                onCallPressed: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              CallWidget(
                char: "M",
                label: "3 min",
                name: "Manoj",
                time: "10:21 PM",
                onCallPressed: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              CallWidget(
                char: "R",
                label: "7 min",
                name: "Spam call",
                time: "10:27 PM",
                onCallPressed: () {},
                isFraud: true,
              ),
            ],
          ),
        ),
      )),
    );
  }

  /// Updated _buttons with onTap
  Widget _buttons({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        height: MediaQuery.sizeOf(context).height * 0.09,
        width: MediaQuery.sizeOf(context).width * 0.25,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 30,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                text,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customCard() {
    return Container(
        height: MediaQuery.sizeOf(context).height * 0.23,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Enable Advanced Blocking",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Unlock premium for stronger offline protection and auto block spammers  ",
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: [
                        TextButton(
                            onPressed: () {}, child: const Text("Learn More")),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                isEnabled = false;
                              });
                            },
                            child: const Text("Dismiss")),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              const SizedBox(height: 70, width: 50, child: Placeholder()),
            ],
          ),
        ));
  }

  Widget mostCalledWidgets({
    required String name,
    required String char,
    required String label,
  }) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(children: [
            CircleAvatar(
              radius: 40,
              child: Center(
                  child: Text(
                char,
                style: TextStyle(fontSize: 24),
              )),
            ),
            Positioned(
              bottom: 0,
              right: 25,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ]),
          Center(
              child: Text(
            name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.call,
                size: 15,
              ),
              Text("mobile"),
            ],
          )
        ],
      ),
    );
  }
}

/// Placeholder page for Favorites / Voice HD
class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          "$title content coming soon...",
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
