import 'package:CCU/models/user.dart';
import 'package:CCU/screens/police/mapPage.dart';
import 'package:CCU/screens/police/policeProfilePage.dart';
import 'package:CCU/screens/police/policeReportsPage.dart';
import 'package:CCU/screens/profilePage.dart';
import 'package:CCU/screens/reportsPage.dart';
import 'package:CCU/screens/discountsPage.dart';
import 'package:CCU/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// TODO: Add loading animation when signing out

class PoliceHome extends StatefulWidget {
  int? receivedIndex;
  PoliceHome({this.receivedIndex, Key? key}) : super(key: key);
  @override
  _PoliceHomeState createState() => _PoliceHomeState();
}

class _PoliceHomeState extends State<PoliceHome> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    PoliceProfilePage(),
    PoliceReportsPage(),
    MapPage()
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
            icon: /*ImageIcon(AssetImage("assets/tag.png"), size: 0.1,),*/ Icon(Icons.map),
            label: 'Map',
          ),
        ],
        selectedItemColor: Colors.blue,
      ),
    );
  }
}
