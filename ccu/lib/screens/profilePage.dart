import 'package:CCU/models/user.dart';
import 'package:CCU/screens/camera/cameraPage.dart';
import 'package:CCU/screens/loading.dart';
import 'package:CCU/screens/wrapper.dart';
import 'package:CCU/services/auth.dart';
import 'package:CCU/services/contractLinking.dart';
import 'package:CCU/services/database.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

List<String> images = ["assets/tomas.png", "assets/rita.png", "assets/albertina.png"];

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
    /*final contractLink = Provider.of<ContractLinking>(context);
    contractLink.getData();
    if(contractLink.isLoading){
      return Loading();
    }*/
  
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: AuthService().getCurrentUser().uid).userData,
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Loading();
        }
        UserData userData = snapshot.data!;

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
                      Positioned(
                        top: top,
                        child:
                        CircleAvatar(               
                          backgroundColor: Colors.blue.shade800,
                          radius: (profileImageHeight / 2) + 5,
                          child:
                          CircleAvatar(
                            radius: profileImageHeight / 2,
                            backgroundColor: Colors.white,
                            backgroundImage:
                            (() {
                            if(_auth.getCurrentUser().displayName! == "Tomas"){
                              return AssetImage(images[0]);
                            }else if(_auth.getCurrentUser().displayName! == "Albertina"){
                              return AssetImage(images[2]);
                            }else if(_auth.getCurrentUser().displayName! == "Rita"){
                              return AssetImage(images[1]);
                            }else{
                              return AssetImage('assets/defaultUser.png');
                            }
                            }())
                          ),
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
                              "Daily Reports",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18.0)
                            ),
                          ),
                          Text(userData.dailyReports.toString()+
                            "/3",
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
                            //contractLink.currentTokens == null ? "0"  : contractLink.currentTokens!,
                            userData.licensePoints.toString(),
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
                            userData.totalReports.toString(),
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    child:
                      Image(
                        image: AssetImage('assets/defaultDL.png'),
                        width: 400,
                        height: 230,
                      )
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