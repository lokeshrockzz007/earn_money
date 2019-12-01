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
                children: <Widget>[
                  Text(
                    "250",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    "  INR",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
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
                  Icons.attach_money,
                  color: Colors.deepOrange,
                ),
                title: Text('Messages'),
                trailing: countInfo(),
                onTap: () {}),
            ListTile(
                leading: Icon(
                  Icons.work,
                  color: Colors.deepOrange,
                ),
                title: Text('Contacts'),
                trailing: countInfo(),
                onTap: () {}),
            ListTile(
              leading: Icon(
                Icons.account_balance_wallet,
                color: Colors.deepOrange,
              ),
              title: Text(
                'Get Current Location',
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.account_balance,
                color: Colors.deepOrange,
              ),
              title: Text(
                'Gallery Images',
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.email,
                color: Colors.deepOrange,
              ),
              title: Text('Take Image'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.remove_circle,
                color: Colors.deepOrange,
              ),
              title: Text('Notifications'),
              onTap: () {
                Navigator.pop(context, 'data');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.remove_circle,
                color: Colors.deepOrange,
              ),
              title: Text('Add Tasks'),
              onTap: () {
                Navigator.pop(context, 'data');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.remove_circle,
                color: Colors.deepOrange,
              ),
              title: Text('Send App Notifications'),
              onTap: () {
                Navigator.pop(context, 'data');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.remove_circle,
                color: Colors.deepOrange,
              ),
              title: Text('Record Audio'),
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
