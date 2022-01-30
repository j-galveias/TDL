import 'dart:io';

import 'package:CCU/screens/camera/reportFormPage.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class PreviewPage extends StatefulWidget {

  final XFile? previewFile;
  const PreviewPage({this.previewFile, Key? key}) : super(key: key);

  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage>{

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Image.file(File(widget.previewFile!.path),),
          SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      color: Colors.transparent,
                      child: ClipOval(
                        child: Material(
                          color: Colors.lightBlue.shade200, // Button color
                          child: InkWell(
                            splashColor: Colors.blue.shade50, // Splash color
                            child: SizedBox(width: 50, height: 50, child: Icon(Icons.close, size: 40, color: Colors.blue,)),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  elevation: 5.0,
                                  backgroundColor: Colors.blue.shade100,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  title: Text("Discard", style: TextStyle(fontSize: 25, color: Colors.blue.shade700),),
                                  content: Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("Are you sure you want to Discard?", style: TextStyle(fontSize: 20, color: Colors.blue.shade700),),
                                        SizedBox(height: 30,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                primary: Colors.blue,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                              ),
                                              onPressed: () {
                                                var count = 0;
                                                Navigator.of(context).popUntil((_) => count++ >= 2);
                                              },
                                              child: Text('Yes', style: TextStyle(color: Colors.blue.shade50),),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                primary: Colors.blue,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('No', style: TextStyle(color: Colors.blue.shade50),),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } 
                          ),
                        ),
                      )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      color: Colors.transparent,
                      child: ClipOval(
                        child: Material(
                          color: Colors.lightBlue.shade200, // Button color
                          child: InkWell(
                            splashColor: Colors.blue.shade50, // Splash color
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  elevation: 5.0,
                                  backgroundColor: Colors.blue.shade100,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  title: Text("Continue", style: TextStyle(fontSize: 25, color: Colors.blue.shade700),),
                                  content: Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("Are you sure you want to Continue?", style: TextStyle(fontSize: 20, color: Colors.blue.shade700),),
                                        SizedBox(height: 30,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                primary: Colors.blue,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.push(context, MaterialPageRoute(builder: 
                                                  (context) => ReportFormPage(previewFile: widget.previewFile)));
                                              },
                                              child: Text('Yes', style: TextStyle(color: Colors.blue.shade50),),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                primary: Colors.blue,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('No', style: TextStyle(color: Colors.blue.shade50),),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );

                            },
                            child: SizedBox(width: 50, height: 50, child: Icon(Icons.arrow_forward, size: 40, color: Colors.blue,)),
                          ),
                        ),
                      )
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

Widget _buildPopupDialog(BuildContext context, String action) {
  return new AlertDialog(
    backgroundColor: Colors.blue.shade100,
    title: Text(action, textAlign: TextAlign.center, style: TextStyle(fontSize: 25, color: Colors.blue),),
    content: Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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