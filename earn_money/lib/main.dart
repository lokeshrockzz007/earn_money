import 'package:earn_money/pages/home.dart';
import 'package:earn_money/pages/login.dart';
import 'package:flutter/material.dart';

import 'AdminPages/host-home.dart';

void main() => runApp(EarnMoney());

class EarnMoney extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Earn Money',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home("Lokes", "Lokeswara.betha@ggktech.com"),
    );
  }
}
