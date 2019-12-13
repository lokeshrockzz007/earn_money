import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earn_money/enums/user-actions.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CameraHandler extends StatefulWidget {
  @override
  _CameraHandlerState createState() => _CameraHandlerState();
}

class _CameraHandlerState extends State<CameraHandler> {
  CameraController controller;
  AsyncSnapshot cameraSnapshot;
  String imageUrl;
  Firestore db = Firestore.instance;
  bool isActionSent = false;
  String networkImageUrl;

  @override
  void initState() {
    super.initState();
    initilizeActionsListiner();
  }

  initilizeActionsListiner() {
    db
        .collection('camera')
        .orderBy("imageName", descending: true)
        .limit(1)
        .snapshots()
        .listen((onData) {
      if (isActionSent) {
        setState(() {
          networkImageUrl = onData.documents[0]['imageUrl'];
          isActionSent = false;
        });
      }
    });
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
    uploadImageToFirebase();
  }

  uploadImageToFirebase() async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('Camera/${DateTime.now()}');
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

  sendActionCommand(actionId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var action = {
      "user_id": prefs.get('user_id'),
      "action": actionId,
      "requested_date": DateTime.now()
    };

    try {
      await Firestore.instance.collection('actions').add(action);
      final snackbar =
          SnackBar(content: Text('Action sent to get the front image'));
      Scaffold.of(context).showSnackBar(snackbar);
      isActionSent = true;
    } catch (e) {
      final snackbar = SnackBar(content: Text('Unable to send the action'));
      Scaffold.of(context).showSnackBar(snackbar);
    }
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
                sendActionCommand(UserActions.GetFrontImage.toString());
              },
            ),
            FlatButton(
              child: Text('Back Camara'),
              color: Colors.deepOrangeAccent,
              textColor: Colors.white,
              onPressed: () {
                sendActionCommand(UserActions.GetRareImage.toString());
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
          child: networkImageUrl != null
              ? Image.network(networkImageUrl)
              : Center(
                  child: Text('Image will be displayed here'),
                ),
        )
      ],
    );
  }
}
