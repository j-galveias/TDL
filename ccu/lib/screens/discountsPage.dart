import 'dart:math';

import 'package:CCU/models/user.dart';
import 'package:CCU/screens/camera/cameraPage.dart';
import 'package:CCU/screens/loading.dart';
import 'package:CCU/services/auth.dart';
import 'package:CCU/services/database.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DiscountsPage extends StatefulWidget {
  @override
  _DiscountsPageState createState() => _DiscountsPageState();
}

class _DiscountsPageState extends State<DiscountsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = true;

  final double topHeight = 150;
  final double barHeight = 60;

  List discounts = [2, 4, 8, 10];
  List discNames = ["20% off first hour", "5% off gas", "40% off first hour", "20% off gas"];


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final top = topHeight - barHeight / 2;
    final bottom = barHeight / 2;
    int available = 0;
    int currentReward = 0;
    double percentage = 0;

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: AuthService().getCurrentUser().uid).userData,
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Loading();
        }
        UserData userData = snapshot.data!;

        for (var i = 0; i < discounts.length; i++) {
          if(userData.rewardPoints >= discounts[i]){
            available += 1;
            percentage = min(1, userData.rewardPoints/ discounts[i]);
            currentReward = i;
          }else{
            percentage = min(1, userData.rewardPoints/ discounts[i]);
            currentReward = i;
            break;
          }
        }

        DateTime now = new DateTime.now();
        var formatter = new DateFormat('dd-MM-yyyy');
        String formattedDate = formatter.format(now);

        if(userData.last_report != formattedDate){
          DatabaseService(uid: AuthService().getCurrentUser().uid).updateUserDataDailyRep();
        }

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
                                onPressed: () async {
                                  if(userData.dailyReports < 3){
                                    await availableCameras().then((value) => Navigator.push(context, 
                                    MaterialPageRoute(builder: (context) => CameraPage(cameras: value))));
                                  }
                                },
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
                                percent: percentage, // 30/100 = 0.3
                                center: Stack(
                                  children: [
                                    Text((percentage * 100).toString() + "%", style: 
                                      TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        foreground: Paint()
                                          ..style = PaintingStyle.stroke
                                          ..strokeWidth = 2
                                          ..color = Colors.white,
                                      ),
                                    ),
                                    Text((percentage * 100).toString() + "%", style: 
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
                              Text("Next Discount: " + userData.rewardPoints.toString() + "/" + discounts[currentReward].toString(), 
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
                              available.toString(),
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
                              discounts.length.toString(),
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
                              userData.rewardPoints.toString(),
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
                        itemCount: discounts.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                if(index < currentReward || (index == 3 && currentReward == 3)){
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => _buildPopupDialog(context, discNames[index]),
                                  );
                                }
                              },
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: userData.rewardPoints < discounts[index] ? Colors.grey[300] : Colors.blue[50],
                                  border: Border.all(
                                    color: userData.rewardPoints < discounts[index] ? Colors.black12 : Colors.blueAccent,
                                    width: 3,
                                  )
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      child: Text(discNames[index], 
                                        style: TextStyle(
                                          color: userData.rewardPoints < discounts[index] ? Colors.black38 : Colors.blue,
                                          fontSize: 20
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                      child: Text(userData.rewardPoints < discounts[index] ? "Not available" : "Redeem", 
                                        style: TextStyle(
                                          color: userData.rewardPoints < discounts[index] ? Colors.black38 : Colors.blue,
                                          fontSize: 20
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
    );
  }
}

Widget _buildPopupDialog(BuildContext context, String discount) {
  return new AlertDialog(
    title: Text(discount, textAlign: TextAlign.center, style: TextStyle(fontSize: 25, color: Colors.blue),),
    content: Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Image(image: AssetImage("assets/qrcode.png")),
          ),
          Center(
            child: FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              textColor: Theme.of(context).primaryColor,
              child: const Text('Close'),
            ),
          ),
        ],
      ),
    ),
  );
}