import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';

class LocationGetter extends StatefulWidget {
  @override
  _LocationGetterState createState() => _LocationGetterState();
}

class _LocationGetterState extends State<LocationGetter> {
  Future<Position> getGeoLocation() async {
    final location = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return location;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getGeoLocation(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Position currentLocation = snapshot.data;
          return ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    "Current location latitude ${currentLocation.latitude} and longitude ${currentLocation.longitude}",
                    style: TextStyle(color: Colors.deepOrange, fontSize: 15),
                  ),
                ),
              ),
              // Container(
              //   margin: EdgeInsets.all(20),
              //   height: (MediaQuery.of(context).size.height - 100),
              //   child: FlutterMap(
              //     options: MapOptions(
              //         center: LatLng(
              //             currentLocation.latitude, currentLocation.longitude),
              //         zoom: 15.0),
              //     layers: [
              //       TileLayerOptions(
              //         urlTemplate:
              //             "https://api.mapbox.com/styles/v1/lokeswararao/ck3u5aron1w1l1clt1hx90p5d/wmts?access_token=pk.eyJ1IjoibG9rZXN3YXJhcmFvIiwiYSI6ImNrM3R6MHdoODAydW4za215dWZuZW1kMm8ifQ.7rQF_FDF88AZLcBQYY2F1g",
              //       ),
              //       MarkerLayerOptions(
              //         markers: [
              //           new Marker(
              //             width: 80.0,
              //             height: 80.0,
              //             point: new LatLng(currentLocation.latitude,
              //                 currentLocation.longitude),
              //             builder: (ctx) => new Container(
              //               child: Icon(
              //                 Icons.location_on,
              //                 color: Colors.red,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //     mapController: mapController,
              //   ),
              // ),
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
