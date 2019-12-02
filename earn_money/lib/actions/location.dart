import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';

class LocationGetter extends StatefulWidget {
  @override
  _LocationGetterState createState() => _LocationGetterState();
}

class _LocationGetterState extends State<LocationGetter> {
  Map<String, double> currentLocation = Map();
  Location location = Location();
  String error = "";

  StreamSubscription<Map<String, double>> locationSubscription;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    currentLocation['latitude'] = 0.0;
    currentLocation['longitude'] = 0.0;
    locationSubscription =
        location.onLocationChanged().listen((Map<String, double> result) {
      setState(() {
        currentLocation = result;
      });
    });
  }

  initPlatformState() async {
    Map<String, double> myLocation;
    try {
      myLocation = await location.getLocation();
      error = "";
    } on PlatformException catch (e) {
      if (e.code == "PERMISSION_DENIED") {
        error = "Permission Denied";
      } else if (e.code == "PERMISSION_DENIED_NERVER_ASK") {
        error =
            "Permission Denied -- Please ask the user the enable the location from the settings";
      }
      myLocation['latitude'] = 0.0;
      myLocation['longitude'] = 0.0;
    } catch (ex) {}
    setState(() {
      currentLocation = myLocation;
    });

    return myLocation;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initPlatformState(),
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData != null) {
          return Container(
            child: CircularProgressIndicator(
              backgroundColor: Colors.deepOrangeAccent,
            ),
          );
        }
        currentLocation =
            projectSnap.data != null ? projectSnap.data : currentLocation;
        return Container(
          child: Center(
            child: Text(
              'Latitude : ${currentLocation['latitude']} / longitude : ${currentLocation['longitude']} - ${error}',
              style: TextStyle(fontSize: 24, color: Colors.green),
            ),
          ),
        );
      },
    );
  }
}
