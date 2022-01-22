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
                            onTap: () => Navigator.of(context).pop(),
                            child: SizedBox(width: 50, height: 50, child: Icon(Icons.close, size: 40, color: Colors.blue,)),
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
                            onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: 
                              (context) => ReportFormPage(previewFile: widget.previewFile))),
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