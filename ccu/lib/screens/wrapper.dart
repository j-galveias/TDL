import 'package:CCU/screens/authenticate/authenticate.dart';
import 'package:CCU/screens/home.dart';
import 'package:CCU/screens/police/policeHome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authenticate/authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return Home or Authenticate

    final user = Provider.of<User?>(context);

    if (user == null || user.displayName == null) {
      return Authenticate();
    } else {
      if(user.displayName == "Police"){
        return PoliceHome();
      }
      print(user.uid);
      return Home();
    }
  }
}
