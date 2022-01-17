import 'package:CCU/models/balcao.dart';
import 'package:CCU/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'screens/home.dart';
import 'screens/loading.dart';
import 'screens/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(StreamProvider<User>.value(
    value: AuthService().user,
    child: MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Wrapper(),
        '/wrapper': (context) => Wrapper(),
        '/home': (context) => Home(),
      },
    ),
  ));
}
