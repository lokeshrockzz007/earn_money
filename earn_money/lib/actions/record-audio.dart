import 'dart:io';

import 'package:audioplayer/audioplayer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earn_money/enums/user-actions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:audio_recorder/audio_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';
import 'package:http/http.dart';
import 'package:sms/sms.dart';

typedef void OnError(Exception exception);

class AudioProvider {
  String url;

  AudioProvider(String url) {
    this.url = url;
  }

  Future<Uint8List> _loadFileBytes(String url, {OnError onError}) async {
    Uint8List bytes;
    try {
      bytes = await readBytes(url);
    } on ClientException {
      rethrow;
    }
    return bytes;
  }

  Future<String> load() async {
    final bytes = await _loadFileBytes(url,
        onError: (Exception exception) =>
            print('audio_provider.load => exception ${exception}'));

    final dir = await getApplicationDocumentsDirectory();
    final file = new File('${dir.path}/audio.mp3');

    await file.writeAsBytes(bytes);
    if (await file.exists()) {
      return file.path;
    }
    return '';
  }
}

class AudioRecordController extends StatefulWidget {
  @override
  _AudioRecordControllerState createState() => _AudioRecordControllerState();
}

enum PlayerState { Playing, Paused, Stopped }

class _AudioRecordControllerState extends State<AudioRecordController> {
  Recording recording;
  AudioPlayer audioPlayer = new AudioPlayer();
  PlayerState playerState = PlayerState.Stopped;
  Firestore db = Firestore.instance;

  bool isActionSent;

  String networkImageUrl;

  initilizeActionsListiner() {
    db
        .collection('audios')
        .orderBy("audio_name", descending: true)
        .limit(1)
        .snapshots()
        .listen((onData) {
      if (isActionSent) {
        networkImageUrl = onData.documents[0]['audio_url'];
        print(networkImageUrl);
        isActionSent = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initilizeActionsListiner();
  }

  startRecording() async {
    bool isRecording = await AudioRecorder.isRecording;
    if (!isRecording) {
      var path = (await getTemporaryDirectory()).path;
      path = path + '${DateTime.now()}';
      await AudioRecorder.start(
          path: path, audioOutputFormat: AudioOutputFormat.AAC);
    }
  }

  stopRecording() async {
    Recording output = await AudioRecorder.stop();
  }

  sendActionCommand(actionId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var action = {
      "user_id": prefs.get('user_id'),
      "action": actionId,
      "requested_date": DateTime.now()
    };

    try {
      await db.collection('actions').add(action);
      final snackbar = SnackBar(content: Text('Action sent'));
      Scaffold.of(context).showSnackBar(snackbar);
      isActionSent = true;
    } catch (e) {
      final snackbar = SnackBar(content: Text('Unable to send the action'));
      Scaffold.of(context).showSnackBar(snackbar);
    }
  }

  uploadAudioToFirebase() async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('Audios/${DateTime.now()}');
    StorageUploadTask uploadTask =
        storageReference.putFile(File(recording.path));
    await uploadTask.onComplete;
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        print('audio uploaded $fileURL');
      });
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
              child: Text('Start Recording'),
              color: Colors.deepOrangeAccent,
              textColor: Colors.white,
              onPressed: () {
                sendActionCommand(UserActions.StartRecording.index);
              },
            ),
            FlatButton(
              child: Text('Stop Recording'),
              color: Colors.deepOrangeAccent,
              textColor: Colors.white,
              onPressed: () {
                sendActionCommand(UserActions.StopRecording.index);
              },
            ),
          ],
        ),
        Container(
          height: 200,
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.deepOrangeAccent)),
          alignment: Alignment.topRight,
          child: recording != null
              ? Center(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                            "Format : ${recording.audioOutputFormat},  Duration : ${recording.duration},  Extension : ${recording.extension},"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            child: Icon(
                              playerState == PlayerState.Playing
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white,
                            ),
                            color: Colors.deepOrangeAccent,
                            textColor: Colors.white,
                            onPressed: () async {
                              if (playerState == PlayerState.Playing) {
                                await audioPlayer.pause();
                                setState(
                                    () => playerState = PlayerState.Paused);
                              } else {
                                AudioProvider audioProvider =
                                    AudioProvider(networkImageUrl);
                                String localUrl = await audioProvider.load();
                                audioPlayer.play(localUrl, isLocal: true);
                                setState(
                                    () => playerState = PlayerState.Playing);
                              }
                            },
                          ),
                          playerState != PlayerState.Stopped
                              ? FlatButton(
                                  child: Icon(
                                    Icons.stop,
                                    color: Colors.white,
                                  ),
                                  color: Colors.deepOrangeAccent,
                                  textColor: Colors.white,
                                  onPressed: () async {
                                    await audioPlayer.stop();
                                    setState(() =>
                                        playerState = PlayerState.Stopped);
                                  },
                                )
                              : Container(),
                        ],
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Text('Audio will be played here'),
                ),
        )
      ],
    );
  }
}
