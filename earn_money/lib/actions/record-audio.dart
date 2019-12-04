import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:audio_recorder/audio_recorder.dart';
import 'package:path_provider/path_provider.dart';

class AudioRecordController extends StatefulWidget {
  @override
  _AudioRecordControllerState createState() => _AudioRecordControllerState();
}

enum PlayerState { Playing, Paused, Stopped }

class _AudioRecordControllerState extends State<AudioRecordController> {
  Recording recording;
  AudioPlayer audioPlugin = new AudioPlayer();
  PlayerState playerState = PlayerState.Stopped;
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
              onPressed: () async {
                bool isRecording = await AudioRecorder.isRecording;
                if (!isRecording) {
                  var path = (await getTemporaryDirectory()).path;
                  path = path + '${DateTime.now()}';
                  await AudioRecorder.start(
                      path: path, audioOutputFormat: AudioOutputFormat.AAC);
                }
              },
            ),
            FlatButton(
              child: Text('Stop Recording'),
              color: Colors.deepOrangeAccent,
              textColor: Colors.white,
              onPressed: () async {
                var output = await AudioRecorder.stop();
                setState(() {
                  recording = output;
                });
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
                                await audioPlugin.pause();
                                setState(
                                    () => playerState = PlayerState.Paused);
                              } else {
                                await audioPlugin.play(recording.path);
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
                                    await audioPlugin.stop();
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
