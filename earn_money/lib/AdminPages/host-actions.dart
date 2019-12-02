import 'package:earn_money/actions/location.dart';
import 'package:earn_money/actions/sms.dart';
import 'package:flutter/material.dart';

class ActionsMenu extends StatelessWidget {
  const ActionsMenu({Key key}) : super(key: key);

  countInfo() {
    return CircleAvatar(
      backgroundColor: Colors.deepOrange,
      radius: 10,
      child: Text(
        "2",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Row(
                children: <Widget>[],
              ),
              accountName: Text("Lokeswararao Betha"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white54,
                child: Text('L'),
              ),
              decoration: BoxDecoration(color: Colors.deepOrangeAccent),
            ),
            ListTile(
                leading: Icon(Icons.dashboard, color: Colors.deepOrange),
                title: Text(
                  'Dashboard',
                ),
                trailing: countInfo(),
                onTap: () {}),
            ListTile(
                leading: Icon(
                  Icons.message,
                  color: Colors.deepOrange,
                ),
                title: Text('Messages'),
                trailing: countInfo(),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MessagesController()),
                  );
                }),
            ListTile(
                leading: Icon(
                  Icons.contacts,
                  color: Colors.deepOrange,
                ),
                title: Text('Contacts'),
                trailing: countInfo(),
                onTap: () {}),
            ListTile(
              leading: Icon(
                Icons.my_location,
                color: Colors.deepOrange,
              ),
              title: Text(
                'Get Current Location',
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LocationGetter()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.image,
                color: Colors.deepOrange,
              ),
              title: Text(
                'Gallery Images',
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.camera_alt,
                color: Colors.deepOrange,
              ),
              title: Text('Take Image'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.notifications_active,
                color: Colors.deepOrange,
              ),
              title: Text('Notifications'),
              onTap: () {
                Navigator.pop(context, 'data');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.add_to_photos,
                color: Colors.deepOrange,
              ),
              title: Text('Add Tasks'),
              onTap: () {
                Navigator.pop(context, 'data');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.add_alert,
                color: Colors.deepOrange,
              ),
              title: Text('Send App Notifications'),
              onTap: () {
                Navigator.pop(context, 'data');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.record_voice_over,
                color: Colors.deepOrange,
              ),
              title: Text('Record Audio'),
              onTap: () {
                Navigator.pop(context, 'data');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.deepOrange,
              ),
              title: Text('Exit'),
              onTap: () {
                Navigator.pop(context, 'data');
              },
            ),
          ],
        ),
      ),
    );
  }
}
