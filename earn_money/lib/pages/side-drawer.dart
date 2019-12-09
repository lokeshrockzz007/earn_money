import 'package:earn_money/main.dart';
import 'package:earn_money/pages/login-page.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key key}) : super(key: key);

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
                title: Text('My Earning'),
                trailing: countInfo(),
                onTap: () {}),
            ListTile(
                leading: Icon(
                  Icons.work,
                  color: Colors.deepOrange,
                ),
                title: Text('Pending Tasks'),
                trailing: countInfo(),
                onTap: () {}),
            ListTile(
              leading: Icon(
                Icons.account_balance_wallet,
                color: Colors.deepOrange,
              ),
              title: Text(
                'Completed Tasks',
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.account_balance,
                color: Colors.deepOrange,
              ),
              title: Text(
                'Withdraw Money',
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.email,
                color: Colors.deepOrange,
              ),
              title: Text('Contact us'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.remove_circle,
                color: Colors.deepOrange,
              ),
              title: Text('Logout'),
              onTap: () {
                MaterialPageRoute(
                    builder: (BuildContext context) => EarnMoney());
              },
            ),
          ],
        ),
      ),
    );
  }
}
