import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileSystem extends StatefulWidget {
  FileSystem({Key key}) : super(key: key);
  @override
  _FileSystemState createState() => _FileSystemState();
}

class _FileSystemState extends State<FileSystem> {
  Directory tempDir;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
            future: getFileSystemInfo(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.none &&
                  snapshot.hasData != null) {
                return Container(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.deepOrangeAccent,
                  ),
                );
              }

              String pathData = snapshot.data != null ? snapshot.data : '';
              return Text(pathData);
            }));
  }

  getFileSystemInfo() async {
    tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    Directory appDocDir = await getApplicationDocumentsDirectory();
    return appDocDir.path;
  }
}
