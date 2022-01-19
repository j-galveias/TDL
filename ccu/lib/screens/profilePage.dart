import 'package:CCU/services/auth.dart';
import 'package:flutter/material.dart';

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

  final double topHeight = 150;
  final double profileImageHeight = 122;

  @override
  Widget build(BuildContext context) {
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
                    'Name',
                    style: TextStyle(
                      fontSize: 25.0,
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
                          "Points",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18.0)
                        ),
                      ),
                      Text(
                        "12",
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

}