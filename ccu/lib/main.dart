import 'package:CCU/models/balcao.dart';
import 'package:CCU/screens/camera/cameraPage.dart';
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
  runApp(StreamProvider<User?>.value(
    value: AuthService().user,
    initialData: null,
    child: MaterialApp(
      onGenerateRoute: (settings) {
        // If you push the PassArguments route
        if (settings.name == '/home') {
          // Cast the arguments to the correct type: ScreenArguments.
          int arg = settings.arguments as int;

          // Then, extract the required data from the arguments and
          // pass the data to the correct screen.
          return MaterialPageRoute(
            builder: (context) {
              return Home(receivedIndex: arg);
            },
          );
        }
        // The code only supports PassArgumentsScreen.routeName right now.
        // Other values need to be implemented if we add them. The assertion
        // here will help remind us of that higher up in the call stack, since
        // this assertion would otherwise fire somewhere in the framework.
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
      initialRoute: '/',
      routes: {
        '/': (context) => Wrapper(),
        '/wrapper': (context) => Wrapper(),
        //'/home': (context) => Home(),
      },
    ),
  ));
}
