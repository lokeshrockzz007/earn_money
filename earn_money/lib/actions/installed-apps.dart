import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appavailability/flutter_appavailability.dart';

class InstalledAppsList extends StatefulWidget {
  InstalledAppsList({Key key}) : super(key: key);

  @override
  _InstalledAppsListState createState() => _InstalledAppsListState();
}

class _InstalledAppsListState extends State<InstalledAppsList> {

   Firestore db = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getInsatlledAppsList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
        
          List<DocumentSnapshot> installedApps =
            snapshot.data !=null ? snapshot.data.documents : [];
              print(installedApps.length);
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
                      title: Text(installedApps[index].data["app_name"].toString()),
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
                                  installedApps[index].data["package_name"].toString())
                              .then((_) {
                            print(
                                "App ${installedApps[index].data["app_name"].toString()} launched!");
                          }).catchError((err) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "App ${installedApps[index].data["app_name"].toString()} not found!")));
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
        }else{
         
          return Container(
            child: CircularProgressIndicator(
              backgroundColor: Colors.deepOrangeAccent,
            ),
          );
         }
        

       
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

  Future<QuerySnapshot> getInsatlledAppsList()  async{
    var data= db.collection('installed_apps').getDocuments();
    return data;
  }
}
