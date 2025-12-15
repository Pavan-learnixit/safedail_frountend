import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:truecaller_clone/features/presentation/pages/assistence_page.dart';
import 'package:truecaller_clone/features/presentation/pages/calls_screen.dart';
import 'package:truecaller_clone/features/presentation/pages/premium_screen.dart';
import '../pages/message_screen.dart';
import '../pages/block_screen.dart';
class CustomBottomNaviaionBarScreen extends StatefulWidget {
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}
class _BottomNavScreenState extends State<CustomBottomNaviaionBarScreen> {
  int _currentIndex = 0;
  BottomNavigationBarItem _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _currentIndex == index;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
          border: isSelected
              ? Border.all(
            color: Colors.white,
            width: 2,
          )
              : null,
        ),
        child: Icon(
          icon,
          size: isSelected ? 32 : 24,
          color: isSelected ? Colors.white : Colors.grey,
        ),
      ),
      label: label,
    );
  }


  // Screens for each tab
  final List<Widget> _screens = [
    CallsScreen(),
    // Container(),
    MessagesScreen(),
    // Container(),
    // Container(),
    // DefaultSmsPage(),
    BlockingScreen(),
    // PremiumScreen(),
    PlaceholderPage(
        title: "Premium page"),
    // Container(),
    AssistantancePage()
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
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          _buildNavItem(Icons.call, 'Calls', 0),
          _buildNavItem(Icons.message, 'Messages', 1),
          _buildNavItem(Icons.block, 'Blocking', 2),
          _buildNavItem(Icons.workspace_premium, 'Premium', 3),
          _buildNavItem(Icons.assistant, 'Assistant', 4),
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
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  isDense: true,
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
