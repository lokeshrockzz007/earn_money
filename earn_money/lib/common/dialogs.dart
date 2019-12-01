import 'package:flutter/material.dart';

class Dialogs {
  static Future showAlertDialog(
      context, titie, message, okAction, closeAction) {
    return showDialog(
        context: context,
        builder: (BuildContext builder) {
          return AlertDialog(
            title: Text(titie),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text(okAction),
                onPressed: () {
                  Navigator.pop(context, {true});
                },
              ),
              FlatButton(
                child: Text(closeAction),
                onPressed: () {
                  Navigator.pop(context, {false});
                },
              )
            ],
          );
        });
  }
}
