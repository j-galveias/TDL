import 'dart:io';

import 'package:CCU/screens/camera/PreviewPage.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {

  final List<CameraDescription>? cameras;
  const CameraPage({this.cameras, Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage>{
  late CameraController controller;
  XFile? pictureFile;
  bool _cameraOn = true;

  @override
  void initState(){
    super.initState();
    controller = CameraController(
      widget.cameras![0],
      ResolutionPreset.max,
    );
    controller.initialize().then((_) {
      if(!mounted){
        return;
      }

      setState(() {});
    });
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(!controller.value.isInitialized || !_cameraOn){
      return const SizedBox(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    /*IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),*/
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Stack(
          children: [
            Center(
              child: Container(
                child: CameraPreview(controller),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  color: Colors.transparent,
                  child: ClipOval(
                    child: Material(
                      color: Colors.lightBlue.shade200, // Button color
                      child: InkWell(
                        splashColor: Colors.blue.shade50, // Splash color
                        onTap: () => Navigator.of(context).pop(),
                        child: SizedBox(width: 50, height: 50, child: Icon(Icons.arrow_back, size: 40, color: Colors.blue,)),
                      ),
                    ),
                  )
                ),
              ),
            ),
          ],
        ),
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              //margin: EdgeInsets.only(bottom: bottom),
              color: Colors.lightBlue.shade100,
              width: double.infinity,
              height: 80,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(120),
                  child: SizedBox(
                    height: 70,
                    width: 70,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlue.shade200,
                        side: BorderSide(width: 2.0, color: Colors.blue),
                        shape: CircleBorder(),
                      ),
                      child: Text(''),
                      onPressed: () async {
                        await controller.takePicture().then((value) => Navigator.push(context, 
                              MaterialPageRoute(builder: (context) => PreviewPage(previewFile: value))));
                        setState(() {});
                        
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        if(pictureFile != null)
          Image.file(File(pictureFile!.path),)
      ],
    );
  }
}