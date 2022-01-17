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
  final AuthService _auth = AuthService();
  final DatabaseService db = DatabaseService();
  
  List<Balcao> _balcs = [];
  bool isLoading = true;

  final double topHeight = 150;
  final double profileImageHeight = 122;
  

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final top = topHeight - profileImageHeight / 2;
    final bottom = profileImageHeight / 2;

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
              Column(
                children: <Widget>[
                  Expanded(
                    child: NotificationListener<ScrollNotification>(
                      /*onNotification: (ScrollNotification scrollInfo) {
                        if (!isLoading &&
                            scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                              setState(() {
                                isLoading = true;
                              });
                          db.getAllBalcs().then((value) {
                            setState(() {
                              if (value == null) {
                                isLoading = false;
                                return;
                              }
                              _balcs = value;
                              isLoading = false;
                            });
                          });
                        }
                      },*/
                      child: ListView.builder(
                        itemCount: _balcs.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 10.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/showBalcao',
                                        arguments: _balcs[index]);
                                  },
                                  child: Stack(
                                    children: <Widget>[
                                      Image.network(_balcs[index].thumbnail,
                                          fit: BoxFit.cover, width: 1000.0),
                                      Positioned(
                                        bottom: 0.0,
                                        left: 0.0,
                                        right: 0.0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color.fromARGB(200, 0, 0, 0),
                                                Color.fromARGB(0, 0, 0, 0)
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 10.0),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  '${_balcs[index].name}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  '${_balcs[index].price}€',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: isLoading ? 50.0 : 0,
                    color: Colors.transparent,
                    child: 
                      Center(
                        child: new CircularProgressIndicator(),
                      ),
                  ),
                ],
              )
           ]
          ),
        )
      );
  }
}