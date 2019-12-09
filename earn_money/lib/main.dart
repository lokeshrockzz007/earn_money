import 'package:earn_money/pages/login-page.dart';
import 'package:flutter/material.dart';

void main() => runApp(EarnMoney());

class EarnMoney extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Earn Money',
      theme: ThemeData(
        cursorColor: Colors.deepOrange,
        inputDecorationTheme: InputDecorationTheme(
          focusColor: Colors.deepOrange,
          fillColor: Colors.deepOrange,
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.orangeAccent, width: 2.0)),
          focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.deepOrangeAccent, width: 2.0)),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepOrange),
          ),
        ),
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
