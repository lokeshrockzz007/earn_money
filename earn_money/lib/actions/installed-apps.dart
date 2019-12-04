import 'package:flutter/material.dart';
import 'package:flutter_appavailability/flutter_appavailability.dart';

class InstalledAppsList extends StatefulWidget {
  InstalledAppsList({Key key}) : super(key: key);

  @override
  _InstalledAppsListState createState() => _InstalledAppsListState();
}

class _InstalledAppsListState extends State<InstalledAppsList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getInsatlledAppsList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData != null) {
          return Container(
            child: CircularProgressIndicator(
              backgroundColor: Colors.deepOrangeAccent,
            ),
          );
        }
        List<Map<String, String>> installedApps =
            snapshot.data != null ? snapshot.data : [];

        return Row(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white70,
                    border: Border.all(color: Colors.deepOrangeAccent)),
                height: 500.0,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: installedApps.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return ListTile(
                      title: Text(installedApps[index]["app_name"]),
                      trailing: FlatButton(
                        color: Colors.orangeAccent,
                        child: Text(
                          'Open',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Scaffold.of(context).hideCurrentSnackBar();
                          AppAvailability.launchApp(
                                  installedApps[index]["package_name"])
                              .then((_) {
                            print(
                                "App ${installedApps[index]["app_name"]} launched!");
                          }).catchError((err) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "App ${installedApps[index]["app_name"]} not found!")));
                            print(err);
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        );
        // return Container(
        //   margin: EdgeInsets.all(20),
        //   padding: EdgeInsets.all(20),
        //   decoration: BoxDecoration(
        //       color: Colors.white70,
        //       border: Border.all(color: Colors.deepOrangeAccent)),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.stretch,
        //     children: <Widget>[
        //       Text(
        //         'Installed Apps',
        //         style: TextStyle(
        //             fontSize: 20,
        //             fontWeight: FontWeight.w500,
        //             color: Colors.deepOrange),
        //       ),
        //       Container(
        //         height: 1,
        //         color: Colors.black12,
        //         margin: EdgeInsets.symmetric(vertical: 5),
        //       ),
        //       ListView(
        //         children: <Widget>[Text("data"),
        //         ],
        //       ),
        //     ],
        //   ),
        // );
      },
    );
  }

  Future<List<Map<String, String>>> getInsatlledAppsList() async {
    List<Map<String, String>> _installedApps =
        await AppAvailability.getInstalledApps();
    return _installedApps;
  }
}
