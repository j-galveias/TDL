import 'package:CCU/models/balcao.dart';
import 'package:CCU/services/auth.dart';
import 'package:CCU/services/database.dart';
import 'package:flutter/material.dart';

class ReportsPage extends StatefulWidget {
  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final DatabaseService db = DatabaseService();

  bool isLoading = true;

  final double topHeight = 150;
  final double profileImageHeight = 122;
  

  @override
  Widget build(BuildContext context) {
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
                        padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                        child: Text("Reports",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      )
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
                            "Daily Reports",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18.0)
                          ),
                        ),
                        Text(
                          "2/3",
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
                            "Approved",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18.0)
                          ),
                        ),
                        Text(
                          "4",
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
                            "Total Reports",
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
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 200,
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
                              Image(
                                image: AssetImage('assets/logo.jpg'),
                                width: 100,
                                height: 180,
                              ),
                              Text("dd/mm/yy", 
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20
                                ),
                              ),
                              Text("To Be Reviewed", 
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