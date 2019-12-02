import 'package:earn_money/actions/device-info.dart';
import 'package:earn_money/actions/installed-apps.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          child: Center(
            child: DeviceInfo(),
          ),
        ),
        InstalledAppsList()
      ],
    );
  }
}
