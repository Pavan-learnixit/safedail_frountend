import 'package:flutter/material.dart';
import 'package:truecaller_clone/features/presentation/pages/who_viewed_me_screen.dart';
import 'package:truecaller_clone/features/presentation/pages/who_searched_me_screen.dart';
import 'package:truecaller_clone/features/presentation/pages/manage_blockings_screen.dart';
import 'package:truecaller_clone/features/presentation/pages/fraud_insurance_screen.dart';

class ProfileModuleScreen extends StatefulWidget {
  @override
  _ProfileModuleScreenState createState() => _ProfileModuleScreenState();
}

class _ProfileModuleScreenState extends State<ProfileModuleScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    WhoViewedMeScreen(),
    WhoSearchedMeScreen(),
    ManageBlockingsScreen(),
    FraudInsuranceScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Safedail Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.remove_red_eye), label: 'Viewed'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Searched'),
          BottomNavigationBarItem(icon: Icon(Icons.block), label: 'Blocked'),
          BottomNavigationBarItem(icon: Icon(Icons.report_problem), label: 'Fraud'),
        ],
      ),
    );
  }
}