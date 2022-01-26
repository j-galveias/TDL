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
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 300,),
          Container(child: Text("TDL", style: TextStyle(fontSize: 100, color: Colors.blue[500]),)),
          SizedBox(height: 100,),
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
