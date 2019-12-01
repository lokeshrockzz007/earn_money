import 'package:earn_money/AdminPages/host-actions.dart';
import 'package:flutter/material.dart';

class HostHome extends StatefulWidget {
  @override
  _HostHomeState createState() => _HostHomeState();
}

class _HostHomeState extends State<HostHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.deepOrange,
          title: Center(
            child: Text("Earn Money"),
          ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.question_answer), onPressed: () {}),
          ],
        ),
        drawer: ActionsMenu());
  }
}
