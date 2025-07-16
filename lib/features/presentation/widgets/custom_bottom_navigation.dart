import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:truecaller_clone/features/presentation/pages/calls_screen.dart';

class CustomBottomNaviaionBarScreen extends StatefulWidget {
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<CustomBottomNaviaionBarScreen> {
  int _currentIndex = 0;

  // Screens for each tab
  final List<Widget> _screens = [
    const CallsScreen(),
    // Container(),
    Container(),
    Container(),
    Container(),
    Container(),
  ];

  // Titles for AppBar
  final List<String> _titles = [
    'Calls',
    'Messages',
    'Blocking',
    'Premium',
    'Assistant'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(200),
      //   child: AppBar(
      //     // leading: _currentIndex == 1 || _currentIndex == 0
      //     //     ? IconButton(
      //     //         icon: Icon(Icons.person),
      //     //         onPressed: () {
      //     //           // Handle profile tap
      //     //         },
      //     //       )
      //     //     : null,
      //     title: _currentIndex == 1 || _currentIndex == 0
      //         ? _buildSearchBar()
      //         : Text(_titles[_currentIndex]),
      //     // actions: _currentIndex == 1 || _currentIndex == 0
      //     //     ? [
      //     //         IconButton(
      //     //           icon: Icon(Icons.more_vert),
      //     //           onPressed: () {
      //     //             // Handle overflow menu
      //     //           },
      //     //         ),
      //     //       ]
      //     //     : [],
      //   ),
      // ),

      // AppBar(title: Text(_titles[_currentIndex])),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Calls',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.block),
            label: 'Blocking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.workspace_premium),
            label: 'Premium',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assistant),
            label: 'Assistant',
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Material(
      elevation: 10,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            IconButton( color: Colors.grey, onPressed: () {  }, icon: Icon(Icons.person),),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  isDense: true,
                ),
                onSubmitted: (value) {
                  // Handle search input
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {

              },
            ),
          ],
        ),
      ),
    );
  }

}
