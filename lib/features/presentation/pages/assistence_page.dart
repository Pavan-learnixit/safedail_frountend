import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truecaller_clone/features/presentation/pages/premium_screen.dart';
import 'package:truecaller_clone/features/presentation/pages/profile_page.dart';
import 'package:truecaller_clone/features/presentation/widgets/search_bar.dart';

import 'call_logs_page.dart';



class AssistantancePage extends StatefulWidget {
  @override
  State<AssistantancePage> createState() => _AssistantancePageState();
}

class _AssistantancePageState extends State<AssistantancePage> {
  TextEditingController searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   // title: TextField(
        //   //   decoration: InputDecoration(
        //   //     hintText: 'Search numbers, names & more',
        //   //     prefixIcon: Icon(Icons.person, color: Colors.blue),
        //   //     suffixIcon: Row(
        //   //       mainAxisSize: MainAxisSize.min,
        //   //       children: [
        //   //         Padding(
        //   //           padding: const EdgeInsets.all(8.0),
        //   //           child: CircleAvatar(
        //   //             radius: 12,
        //   //             backgroundColor: Colors.blue,
        //   //             child: Text('15', style: TextStyle(color: Colors.white, fontSize: 10)),
        //   //           ),
        //   //         ),
        //   //         IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        //   //       ],
        //   //     ),
        //   //     border: OutlineInputBorder(
        //   //       borderRadius: BorderRadius.circular(8.0),
        //   //       borderSide: BorderSide(color: Colors.grey),
        //   //     ),
        //   //     focusedBorder: OutlineInputBorder(
        //   //       borderRadius: BorderRadius.circular(8.0),
        //   //       borderSide: BorderSide(color: Colors.blue),
        //   //     ),
        //   //   ),
        //   // ),
        // ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.person),
                      color: Theme.of(context).colorScheme.primary,
                      iconSize: 28,
                      splashRadius: 24,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ProfilePage()),
                        );
                      },
                    ),
                    Expanded(
                      child: buildSearchBar(
                        context: context,
                        controller: searchController,
                        suffixOnPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const CallLogsPage()),
                          );
                        },
                        prefixOnPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (_) => const ProfilePage()),
                          // );
                        },
                        onSubmitted: (value) {},
                        height: 60,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      color: Theme.of(context).colorScheme.primary,
                      iconSize: 28,
                      splashRadius: 24,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const CallLogsPage()),
                        );
                      },
                    )

                  ],
                ),
          
                ListTile(
                  title: Text('Assistant status'),
                  trailing: Icon(Icons.settings),
                  subtitle: Text('Inactive', style: TextStyle(color: Colors.red)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child:const  Text('All'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(Icons.call),
                          Text('Caller replied'),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(Icons.assistant, size: 50, color: Colors.blue),
                          SizedBox(height: 10),
                          Text(
                            'Get our AI Assistant',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text('Upgrade to Premium to allow the Assistant to answer incoming calls for you'),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const PremiumScreen()),
                              );
                            },
                            child: Text('Upgrade'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Text('No Assistant calls'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}