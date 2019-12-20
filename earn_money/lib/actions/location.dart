import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earn_money/enums/user-actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationGetter extends StatefulWidget {
  @override
  _LocationGetterState createState() => _LocationGetterState();
}

class _LocationGetterState extends State<LocationGetter> {
  var location;
  Firestore db = Firestore.instance;
  MapController mapController;

  bool isActionSent;
  getGeoLocation() {
    return db
        .collection('geo_location')
        .orderBy("last_updated", descending: true)
        .limit(1)
        .snapshots();
  }

  sendActionCommand(actionId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var action = {
      "user_id": prefs.get('user_id'),
      "action": actionId,
      "requested_date": DateTime.now()
    };

    try {
      await Firestore.instance.collection('actions').add(action);
      final snackbar =
          SnackBar(content: Text('Action sent to get camera image'));
      Scaffold.of(context).showSnackBar(snackbar);
      isActionSent = true;
    } catch (e) {
      final snackbar = SnackBar(content: Text('Unable to send the action'));
      Scaffold.of(context).showSnackBar(snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getGeoLocation(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot> locationSnapshot) {
        if (locationSnapshot.hasData) {
          var currentLocation = locationSnapshot.data.documents.first.data;
          print(currentLocation);
          return ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    "Current location latitude ${currentLocation['latitude']} and longitude ${currentLocation['longitude']}",
                    style: TextStyle(color: Colors.deepOrange, fontSize: 15),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: Center(
                  child: FlatButton(
                    child: Text('Refresh Location'),
                    color: Colors.deepOrangeAccent,
                    textColor: Colors.white,
                    onPressed: () {
                      sendActionCommand(UserActions.GetCurrentLocation.index);
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                height: (MediaQuery.of(context).size.height - 200),
                child: FlutterMap(
                  options: MapOptions(
                      center: LatLng(currentLocation['latitude'],
                          currentLocation['longitude']),
                      zoom: 15.0),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          "https://api.mapbox.com/styles/v1/lokeswararao/ck3u5aron1w1l1clt1hx90p5d/wmts?access_token=pk.eyJ1IjoibG9rZXN3YXJhcmFvIiwiYSI6ImNrM3R6MHdoODAydW4za215dWZuZW1kMm8ifQ.7rQF_FDF88AZLcBQYY2F1g",
                    ),
                    MarkerLayerOptions(
                      markers: [
                        new Marker(
                          width: 80.0,
                          height: 80.0,
                          point: new LatLng(currentLocation['latitude'],
                              currentLocation['longitude']),
                          builder: (ctx) => new Container(
                            child: Icon(
                              Icons.location_on,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  mapController: mapController,
                ),
              ),
            ],
          );
        } else {
          return CircularProgressIndicator(
              backgroundColor: Colors.deepOrangeAccent);
        }
      },
    );
  }

  void dispose() {
    super.dispose();
  }
}
