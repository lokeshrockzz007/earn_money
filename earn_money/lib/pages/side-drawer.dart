import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key key}) : super(key: key);

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
                title: Text('Dashboard'),
                trailing: Icon(Icons.dashboard, color: Colors.deepOrange),
                onTap: () {}),
            ListTile(
                title: Text('My Earning'),
                trailing: Icon(
                  Icons.attach_money,
                  color: Colors.deepOrange,
                ),
                onTap: () {}),
            ListTile(
                title: Text('Pending Tasks'),
                trailing: Icon(
                  Icons.work,
                  color: Colors.deepOrange,
                ),
                onTap: () {}),
            ListTile(
              title: Text(
                'Completed Tasks',
              ),
              trailing: Icon(
                Icons.account_balance_wallet,
                color: Colors.deepOrange,
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Withdraw Money',
              ),
              trailing: Icon(
                Icons.account_balance,
                color: Colors.deepOrange,
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text('Contact us'),
              trailing: Icon(
                Icons.email,
                color: Colors.deepOrange,
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text('Logout'),
              trailing: Icon(
                Icons.remove_circle,
                color: Colors.deepOrange,
              ),
              onTap: () {
                Navigator.pop(context, 'data');
              },
            ),
          ],
        ),
      ),
      ,
    );
  }
}