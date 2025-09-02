import 'package:flutter/material.dart';
import 'package:truecaller_clone/features/presentation/pages/assistence_page.dart';
import 'package:truecaller_clone/features/presentation/pages/block_screen.dart';
import 'package:truecaller_clone/features/presentation/pages/calls_screen.dart';
import 'package:truecaller_clone/features/presentation/pages/message_screen.dart';
import 'package:truecaller_clone/features/presentation/pages/premium_screen.dart';

class CustomBottomNaviaionBarScreen extends StatefulWidget {
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<CustomBottomNaviaionBarScreen> {
  int _currentIndex = 0;

  // Screens for each tab (must match BottomNavigationBar items)
  final List<Widget> _screens = [
    const CallsScreen(),
    MessagesScreen(),
    BlockingScreen(),
    premiumscreen(),
    AssistantancePage(),
  ];

  // Titles for AppBar
  final List<String> _titles = [
    'Calls',
    'Messages',
    'Blocking',
    'Premium',
    'Assistant',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (_currentIndex == 0 || _currentIndex == 1)
            ? _buildSearchBar()
            : Text(_titles[_currentIndex]),
        backgroundColor: Colors.blueAccent,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
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
      elevation: 2,
      color: Colors.transparent,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.grey),
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
            Icon(Icons.more_vert, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
