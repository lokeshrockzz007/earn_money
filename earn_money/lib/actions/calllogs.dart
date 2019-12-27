import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earn_money/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';

class CallLogsController extends StatefulWidget {
  CallLogsController({Key key}) : super(key: key);

  @override
  _CallLogsControllerState createState() => _CallLogsControllerState();
}

class _CallLogsControllerState extends State<CallLogsController> {
  Firestore db = Firestore.instance;
  Future<QuerySnapshot> getLogs() async {
    return db.collection(FirebaseTables.Call_logs).getDocuments();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getLogs(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> callLogs =
                snapshot.data != null ? snapshot.data.documents : [];
            if (callLogs.length > 0) {
              return ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(callLogs[index].data['name'].toString()),
                      subtitle: Text(callLogs[index].data['number'].toString()),
                      onTap: () {},
                      leading: Icon(Icons.phone),
                      trailing:
                          Text(callLogs[index].data['duration'].toString()),
                    );
                  },
                  itemCount: callLogs.length);
            } else {
              return Center(
                child: Text('No Call logs found'),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.deepOrange,
              ),
            );
          }
        },
      ),
    );
  }
}
