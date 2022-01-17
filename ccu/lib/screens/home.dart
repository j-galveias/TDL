import 'package:CCU/screens/profilePage.dart';
import 'package:CCU/screens/reportsPage.dart';
import 'package:CCU/screens/discountsPage.dart';
import 'package:CCU/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// TODO: Add loading animation when signing out

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  int _currentIndex = 0;

  final List<Widget> _children = [
    ProfilePage(),
    ReportsPage(),
    DiscountsPage()
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_alt_outlined ),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money_off),
            label: 'Discounts',
          ),
        ],
        selectedItemColor: Colors.blue,
      ),
    );
  }
}
