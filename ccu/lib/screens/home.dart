import 'package:CCU/screens/profilePage.dart';
import 'package:CCU/screens/reportsPage.dart';
import 'package:CCU/screens/discountsPage.dart';
import 'package:CCU/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// TODO: Add loading animation when signing out

class Home extends StatefulWidget {
  int? receivedIndex;
  Home({this.receivedIndex, Key? key}) : super(key: key);
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
    if(widget.receivedIndex != -1 && widget.receivedIndex != null){
      _currentIndex = widget.receivedIndex!;
      widget.receivedIndex = -1;
    }

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
            icon: Icon(Icons.note_alt_outlined),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: /*ImageIcon(AssetImage("assets/tag.png"), size: 0.1,),*/ Icon(Icons.money_off),
            label: 'Discounts',
          ),
        ],
        selectedItemColor: Colors.blue,
      ),
    );
  }
}
