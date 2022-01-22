import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:CCU/screens/home.dart';

class SubmitedReportPage extends StatefulWidget {

  final XFile? previewFile;
  final String? description;
  final String? infraction;
  final String? licensePlate;
  final String? location;
  const SubmitedReportPage({
    this.previewFile, 
    this.description, 
    this.infraction, 
    this.licensePlate, 
    this.location, 
    Key? key}) : super(key: key);

  @override
  _SubmitedReportPageState createState() => _SubmitedReportPageState();
}

class _SubmitedReportPageState extends State<SubmitedReportPage>{
  
  final double topHeight = 150;
  final double profileImageHeight = 122;

  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy HH:mm');
    String formattedDate = formatter.format(now);
    DateTime date = new DateTime(now.day, now.month, now.year, now.hour, now.minute);
    return SafeArea(
        child: Scaffold(
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
                        child: Text("Report Submitted",
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
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent, width: 3)
                  ),
                  height: 200,
                  child: Image.file(File(widget.previewFile!.path),),
                ),
              ),
              SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Text("Description:", 
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Container(
                      height: 100,
                      width: 260,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 0, 8, 0),
                    child: Text("Type:",
                      //textAlign: TextAlign.end, 
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Text(widget.infraction!,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 0, 8, 0),
                    child: Text("License:\nPlate",
                      //textAlign: TextAlign.end, 
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Text(widget.licensePlate!,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 8, 0),
                    child: Text("Location:",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Text(widget.location!,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 0, 8, 0),
                    child: Text("Date:",
                      //textAlign: TextAlign.end, 
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Text(formattedDate,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ]
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false, arguments: index); 
            },
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.note_alt_outlined),
                label: 'Reports',
              ),
              BottomNavigationBarItem(
                icon: /*ImageIcon(AssetImage("assets/tag.png"), size: 0.1,),*/ Icon(Icons.money_off),
                label: 'Discounts',
              ),
            ],
            selectedItemColor: Colors.grey.shade600,
          ),
        )
    );
  }
}