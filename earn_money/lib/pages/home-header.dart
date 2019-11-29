import 'package:flutter/material.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({Key key}) : super(key: key);

  @override
  _HomeHeaderState createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: FittedBox(
            fit: BoxFit.contain, // otherwise the logo will be tiny
            child: const FlutterLogo(),
          ),
        ),
        ListView(
          children: <Widget>[Text('data')],
        ),
      ],
    );
  }
}
