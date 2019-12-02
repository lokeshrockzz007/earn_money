import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';

class DeviceInfo extends StatefulWidget {
  DeviceInfo({Key key}) : super(key: key);

  @override
  _DeviceInfoState createState() => _DeviceInfoState();
}

class _DeviceInfoState extends State<DeviceInfo> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo device = await deviceInfo.androidInfo;
    return device;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none &&
              projectSnap.hasData != null) {
            return Container(
              child: CircularProgressIndicator(
                backgroundColor: Colors.deepOrangeAccent,
              ),
            );
          }
          AndroidDeviceInfo deviceInfo =
              projectSnap.data != null ? projectSnap.data : null;
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
                            "Device Brand  - ${deviceInfo.product}",
                            style: TextStyle(fontSize: 14),
                          ),
                          Container(height: 15),
                          Text(
                            "Android Version - ${deviceInfo.version.release}",
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
        },
        future: getDeviceInfo(),
      ),
    );
  }
}
