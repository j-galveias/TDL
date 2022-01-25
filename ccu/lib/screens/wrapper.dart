import 'package:CCU/screens/authenticate/authenticate.dart';
import 'package:CCU/screens/home.dart';
import 'package:CCU/screens/police/policeHome.dart';
import 'package:CCU/services/contractLinking.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authenticate/authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return Home or Authenticate

    final user = Provider.of<User?>(context);

    return ChangeNotifierProvider<ContractLinking>(
      create: (_) => ContractLinking(),
      child: 
      (user == null || user.displayName == null) ? Authenticate() : (user.displayName == "Police") ? PoliceHome() : Home()
    );
  }
}
