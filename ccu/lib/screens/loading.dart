import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[500],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 8,
            child: Image.asset(
              'assets/logo.jpg',
              width: 200,
              height: 200,
            ),
          ),
          Expanded(
            flex: 2,
            child: SpinKitDoubleBounce(
              color: Colors.blue[900],
              size: 50.0,
            ),
          ),
        ],
      ),
    );
  }
}
