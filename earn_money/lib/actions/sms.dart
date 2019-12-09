import 'package:earn_money/common/dialogs.dart';
import 'package:earn_money/firebase/senders.dart';
import 'package:flutter/material.dart';
import 'package:sms/sms.dart';

class MessagesController extends StatefulWidget {
  @override
  _MessagesControllerState createState() => _MessagesControllerState();
}

class _MessagesControllerState extends State<MessagesController> {
  SmsQuery query = new SmsQuery();
  List<SmsMessage> messages;
  TextEditingController _textFieldController = TextEditingController();
  String error = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none &&
              projectSnap.hasData) {
            //print('project snapshot data is: ${projectSnap.data}');
            return Container();
          }

          return projectSnap.data != null
              ? ListView.builder(
                  itemCount: projectSnap.data.length,
                  itemBuilder: (context, index) {
                    SmsMessage sms = projectSnap.data[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(20),
                          height: 20,
                          decoration: BoxDecoration(),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SimpleDialog(
                                      contentPadding: EdgeInsets.all(20),
                                      title: Center(
                                        child: Text(
                                          'New Message',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      children: <Widget>[
                                        TextField(
                                          controller: _textFieldController,
                                          decoration: InputDecoration(
                                              hintText: "Phone Number"),
                                        ),
                                        TextField(
                                          controller: _textFieldController,
                                          decoration: InputDecoration(
                                              hintText: "Message Body"),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            FlatButton(
                                              textColor:
                                                  Colors.deepOrangeAccent,
                                              child: Text('cancle'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            FlatButton(
                                              color: Colors.deepOrangeAccent,
                                              textColor: Colors.white,
                                              child: Text('Send'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  });
                            },
                            child: Text(
                              'New Message',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.deepOrange,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                        ListTile(
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
                        ),
                      ],
                    );
                  },
                )
              : CircularProgressIndicator(
                  backgroundColor: Colors.deepOrangeAccent,
                );
        },
        future: getAllMessages(),
      ),
    );
  }

  getAllMessages() async {
    Senders send = Senders();
    return send.getAllMessages();
  }
}
