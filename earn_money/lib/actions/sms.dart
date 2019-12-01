import 'package:earn_money/common/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:sms/sms.dart';

class MessagesController extends StatefulWidget {
  @override
  _MessagesControllerState createState() => _MessagesControllerState();
}

class _MessagesControllerState extends State<MessagesController> {
  SmsQuery query = new SmsQuery();
  List<SmsMessage> messages;
  String error = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Container();
        }
        return ListView.builder(
          itemCount: projectSnap.data.length,
          itemBuilder: (context, index) {
            SmsMessage sms = projectSnap.data[index];
            return ListTile(
              title: Text(sms.address),
              subtitle: Text(sms.body),
              leading: Icon(
                Icons.message,
                color: Colors.orange,
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Colors.redAccent,
                onPressed: () {
                  Dialogs.showAlertDialog(
                          context,
                          "Delele Confirmation",
                          "Are you sure ! you want to delete this message",
                          "Delete",
                          "Close")
                      .then((onValue) {
                    print("Message removed");
                  });
                },
              ),
            );
          },
        );
      },
      future: getAllMessages(),
    );
  }

  getAllMessages() async {
    return await query.getAllSms;
  }
}
