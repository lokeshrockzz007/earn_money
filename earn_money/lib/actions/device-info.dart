import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';

class DeviceInfo extends StatefulWidget {
  DeviceInfo({Key key}) : super(key: key);

  @override
  _DeviceInfoState createState() => _DeviceInfoState();
}

class _DeviceInfoState extends State<DeviceInfo> {
   Firestore db = Firestore.instance;
  @override
  void initState() {
    super.initState();
  }

    getDeviceInfo()  {
     return  db.collection('device_info').limit(1).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: getDeviceInfo(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> projectSnap) {
              if (projectSnap.hasData) {
                  var deviceInfo =
                  projectSnap.data != null ? projectSnap.data.documents.first.data : null;
                  print(deviceInfo);
                 return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  deviceInfo != null
                      ? Container(
                          height: 150,
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white70,
                              border: Border.all(color: Colors.deepOrangeAccent)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                'Device Info',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.deepOrange),
                              ),
                              Container(
                                height: 1,
                                color: Colors.black26,
                                margin: EdgeInsets.symmetric(vertical: 5),
                              ),
                              Text(
                                "Device Brand  - ${deviceInfo['brand']}",
                                style: TextStyle(fontSize: 14),
                              ),
                              Container(height: 15),
                              Text(
                                "Android Version - ${deviceInfo['version']}",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Text("Getting Device Information"),
                ],
              );
                
              } else{
return Container(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.deepOrangeAccent,
                  ),
                );
              }
              
             
        }
      ),
    );
  }
}
