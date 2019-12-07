import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';

class CallLogsController extends StatefulWidget {
  CallLogsController({Key key}) : super(key: key);

  @override
  _CallLogsControllerState createState() => _CallLogsControllerState();
}

class _CallLogsControllerState extends State<CallLogsController> {
  getLogs() async {
    var result = await CallLog.get();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getLogs(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Iterable<CallLogEntry> callLogs =
                snapshot.data != null ? snapshot.data : [];
            if (callLogs.length > 1) {
              return ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(callLogs.elementAt(index).name),
                      subtitle: Text(callLogs.elementAt(index).number),
                      onTap: () {},
                      leading: Icon(Icons.phone),
                      trailing:
                          Text(callLogs.elementAt(index).duration.toString()),
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
