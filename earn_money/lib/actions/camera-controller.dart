import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CameraHandler extends StatefulWidget {
  @override
  _CameraHandlerState createState() => _CameraHandlerState();
}

class _CameraHandlerState extends State<CameraHandler> {
  CameraController controller;
  AsyncSnapshot cameraSnapshot;
  String imageUrl;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  captureImage() async {
    final path = join(
      // Store the picture in the temp directory.
      // Find the temp directory using the `path_provider` plugin.
      (await getTemporaryDirectory()).path,
      '${DateTime.now()}.png',
    );
    await controller.takePicture(path);
    setState(() {});
    imageUrl = path;
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('Camera ${DateTime.now()}');
    StorageUploadTask uploadTask = storageReference.putFile(File(imageUrl));
    await uploadTask.onComplete;
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        print('image uploaded $fileURL');
      });
    });
  }

  setCameraController(isFrontCame) {
    controller = CameraController(
        isFrontCame ? cameraSnapshot.data[1] : cameraSnapshot.data[0],
        ResolutionPreset.medium);
    controller.initialize().then((response) {
      if (cameraSnapshot.connectionState == ConnectionState.done) {
        captureImage();
      } else {
        return Center(child: CircularProgressIndicator());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('Front Camera'),
              color: Colors.deepOrangeAccent,
              textColor: Colors.white,
              onPressed: () {
                setCameraController(true);
              },
            ),
            FlatButton(
              child: Text('Back Camara'),
              color: Colors.deepOrangeAccent,
              textColor: Colors.white,
              onPressed: () {
                setCameraController(false);
              },
            ),
          ],
        ),
        FutureBuilder(
          future: availableCameras(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              cameraSnapshot = snapshot;
              return Container(height: 10);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        Container(
          height: 500,
          width: 500,
          decoration:
              BoxDecoration(border: Border.all(color: Colors.deepOrangeAccent)),
          alignment: Alignment.center,
          child: imageUrl != null
              ? Image.file(File(imageUrl))
              : Center(
                  child: Text('Image will be displayed here'),
                ),
        )
      ],
    );
  }
}
