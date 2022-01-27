
import 'package:CCU/models/policeUser.dart';
import 'package:CCU/models/report.dart';
import 'package:CCU/models/user.dart';
import 'package:CCU/screens/loading.dart';
import 'package:CCU/screens/police/analyseReportPage.dart';
import 'package:CCU/services/auth.dart';
import 'package:CCU/services/database.dart';
import 'package:flutter/material.dart';

class PoliceReportsPage extends StatefulWidget {
  @override
  _PoliceReportsPageState createState() => _PoliceReportsPageState();
}

class _PoliceReportsPageState extends State<PoliceReportsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  List<Report> _reports = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    DatabaseService(uid: AuthService().getCurrentUser().uid)
      .getAllReports(true).then((value) {
        setState(() {
          if (value == null) {
            isLoading = false;
            //return;
          }
          _reports = value;
          isLoading = false;
        });
    });
  }

  final double topHeight = 150;
  final double profileImageHeight = 122;
  

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PoliceUserData>(
      stream: DatabaseService(uid: AuthService().getCurrentUser().uid).policeUserData,
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Loading();
        }
        PoliceUserData userData = snapshot.data!;
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
                                "Reports to be reviewed",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18.0)
                              ),
                            ),
                            Text(userData.reports_to_be_reviewed.toString(),
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
                              userData.total_reports.toString(),
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
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo){
                          if (!isLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                            setState(() {
                              isLoading = true;
                            });
                            DatabaseService(uid: AuthService().getCurrentUser().uid)
                              .getAllReports(true).then((value) {
                                setState(() {
                                  if (value == null) {
                                    isLoading = false;
                                    return;
                                  }
                                  _reports = value;
                                  isLoading = false;
                                });
                            });
                          }
                          return true;
                        },
                        child: ListView.builder(
                          itemCount: _reports.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context) => AnalyseReportPage(report: _reports[index])))
                                   .then((_) => 
                                    DatabaseService(uid: AuthService().getCurrentUser().uid)
                                      .getAllReports(true).then((value) {
                                        setState(() {
                                          if (value == null) {
                                            isLoading = false;
                                            //return;
                                          }
                                          _reports = value;
                                          isLoading = false;
                                        });
                                      })
                                   );
                                   
                                },
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
                                      Image(
                                        image: NetworkImage(_reports[index].image),
                                        width: 100,
                                        height: 180,
                                      ),
                                      Container(
                                        width: 105,
                                        child: Text(_reports[index].date.substring(0, 16), 
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 20
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 90,
                                        child: Text(_reports[index].status, 
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
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
                  ),
                  Container(
                    height: isLoading && _reports.length > 0 ? 50.0 : 0,
                    color: Colors.transparent,
                    child: Center(
                      child: new CircularProgressIndicator(),
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