import 'package:CCU/models/policeUser.dart';
import 'package:CCU/models/user.dart';
import 'package:CCU/screens/camera/cameraPage.dart';
import 'package:CCU/screens/loading.dart';
import 'package:CCU/screens/wrapper.dart';
import 'package:CCU/services/auth.dart';
import 'package:CCU/services/database.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PoliceProfilePage extends StatefulWidget {
  @override
  _PoliceProfilePageState createState() => _PoliceProfilePageState();
}

class _PoliceProfilePageState extends State<PoliceProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BodyWidget();
  }
}


class BodyWidget extends StatefulWidget {
  @override
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AuthService _auth = AuthService();
  final DatabaseService db = DatabaseService();

  final double topHeight = 150;
  final double profileImageHeight = 122;

  @override
  Widget build(BuildContext context) {
    
    final top = topHeight - profileImageHeight / 2;
    final bottom = profileImageHeight / 2;
  
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
                      Positioned(
                        top: top,
                        child: 
                          CircleAvatar(
                            radius: profileImageHeight / 2,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage('assets/defaultUser.png'),
                          ),
                      ),  
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child:
                      Text(
                        _auth.getCurrentUser().displayName!,
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0,
                          color: Colors.blue,),
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Divider(
                      endIndent: 15,
                      indent: 15,
                      thickness: 1.8,
                      color: Colors.blue[200],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Text(
                              "Reports to be Reviewed",
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
                  Container(
                    height: 230,
                  ),
                  TextButton.icon(
                    onPressed: () async {
                      await _auth.signOut();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Wrapper()),
                            (_) => false
                    );
                    },
                    icon: 
                      Icon(
                        Icons.logout_outlined,
                        color: Colors.black,
                        ), 
                    label: 
                      Text(
                        "Log Out",
                        style: TextStyle(
                          color: Colors.blue, 
                          fontSize: 22.0)
                      ),
                  )
               ]
              ),
            )
          );
      }
    );
  }

}