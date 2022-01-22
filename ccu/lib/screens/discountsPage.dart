import 'package:CCU/models/balcao.dart';
import 'package:CCU/services/auth.dart';
import 'package:CCU/services/database.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DiscountsPage extends StatefulWidget {
  @override
  _DiscountsPageState createState() => _DiscountsPageState();
}

class _DiscountsPageState extends State<DiscountsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AuthService _auth = AuthService();
  final DatabaseService db = DatabaseService();
  
  List<Balcao> _balcs = [];
  bool isLoading = true;

  final double topHeight = 150;
  final double barHeight = 60;


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final top = topHeight - barHeight / 2;
    final bottom = barHeight / 2;

    return SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          body: 
          Column(
            children: <Widget>[
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: bottom),
                    color: Colors.blue,
                    width: double.infinity,
                    height: topHeight,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text("TDL", 
                        style:
                          TextStyle(
                            color: Colors.white,
                            fontSize: 50
                          ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(280, 0, 0, 0),
                    child: Column(
                      children: [
                        IconButton (
                          icon: 
                            Icon(
                              Icons.photo_camera,
                              size: 60,
                              color: Colors.white,
                            ), 
                            onPressed: () {},
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 15, 0, 0),
                          child: 
                            Text(
                              "Report",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white
                              ),
                            ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: 
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 85, 0, 0),
                        child: Text("Discounts",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      )
                  ),
                  Positioned(
                    top: top,
                    child: Container(
                      width: 242,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.blue[700],
                        border: Border.all(
                          color: Colors.lightBlue.shade100,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          LinearPercentIndicator( //leaner progress bar
                            width: 240, //width for progress bar
                            animation: true, //animation to show progress at first
                            animationDuration: 1000,
                            lineHeight: 30.0, //height of progress bar
                            percent: 0.3, // 30/100 = 0.3
                            center: Stack(
                              children: [
                                Text("30.0%", style: 
                                  TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 2
                                      ..color = Colors.white,
                                  ),
                                ),
                                Text("30.0%", style: 
                                  TextStyle(
                                    color: Colors.blue[900],
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            linearStrokeCap: LinearStrokeCap.butt, //make round cap at start and end both
                            progressColor: Colors.blue, //percentage progress bar color
                            backgroundColor: Colors.blue[50],  //background progressbar color
                          ),
                          Text("Next Discount", 
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.blue[50],
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Text(
                            "Available",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18.0)
                          ),
                        ),
                        Text(
                          "2",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18.0),
                        ),
                      ],
                    ),
                    Container(
                      height: 80, 
                      child: 
                        VerticalDivider(
                          thickness: 1.8,
                          color: Colors.blue[200])
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Text(
                            "Total",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18.0)
                          ),
                        ),
                        Text(
                          "6",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18.0),
                        ),
                      ],
                    ),
                    Container(
                      height: 80, 
                      child: 
                        VerticalDivider(
                          thickness: 1.8,
                          color: Colors.blue[200])
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Text(
                            "Points",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18.0)
                          ),
                        ),
                        Text(
                          "10",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0,10,0,0),
                  child: ListView.builder(
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            border: Border.all(
                              color: Colors.blueAccent,
                              width: 3,
                            )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("20% off first hour", 
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20
                                ),
                              ),
                              Text("Redeem", 
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
           ]
          ),
        )
      );
  }
}