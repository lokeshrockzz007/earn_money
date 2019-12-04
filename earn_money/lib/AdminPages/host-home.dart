import 'package:earn_money/actions/camera-controller.dart';
import 'package:earn_money/actions/contacts.dart';
import 'package:earn_money/actions/dashboard.dart';
import 'package:earn_money/actions/file-system.dart';
import 'package:earn_money/actions/notification-manager.dart';
import 'package:earn_money/actions/notifications-list.dart';
import 'package:earn_money/actions/record-audio.dart';
import 'package:earn_money/actions/sms.dart';
import 'package:earn_money/common/permission-manager.dart';
import 'package:flutter/material.dart';
import 'package:notifications/notifications.dart';

class HostHome extends StatefulWidget {
  @override
  _HostHomeState createState() => _HostHomeState();
}

class _HostHomeState extends State<HostHome> {
  PermissionManager _permissionManager = PermissionManager();
  NotificationsManager notificationsManager;
  List<NotificationEvent> notificationsList;
  int _selectedDrawerIndex = 0;
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
  void initState() {
    // TODO: implement initState
    super.initState();
    _permissionManager.getPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepOrange,
        title: Center(
          child: Text("Earn Money"),
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.question_answer), onPressed: () {}),
        ],
      ),
      drawer: Container(
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
                  onTap: () {
                    setState(() {
                      _selectedDrawerIndex = 0;
                    });
                    Navigator.pop(context, 'data');
                  }),
              ListTile(
                  leading: Icon(
                    Icons.message,
                    color: Colors.deepOrange,
                  ),
                  title: Text('Messages'),
                  trailing: countInfo(),
                  onTap: () {
                    setState(() {
                      _selectedDrawerIndex = 1;
                    });
                    Navigator.pop(context, 'data');
                  }),
              ListTile(
                  leading: Icon(
                    Icons.contacts,
                    color: Colors.deepOrange,
                  ),
                  title: Text('Contacts'),
                  trailing: countInfo(),
                  onTap: () {
                    setState(() {
                      _selectedDrawerIndex = 3;
                    });
                    Navigator.pop(context, 'data');
                  }),
              ListTile(
                leading: Icon(
                  Icons.my_location,
                  color: Colors.deepOrange,
                ),
                title: Text(
                  'Get Current Location',
                ),
                onTap: () {
                  setState(() {
                    _selectedDrawerIndex = 2;
                  });
                  Navigator.pop(context, 'data');
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
                onTap: () {
                  setState(() {
                    _selectedDrawerIndex = 5;
                  });
                  Navigator.pop(context, 'data');
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.notifications_active,
                  color: Colors.deepOrange,
                ),
                title: Text('Notifications'),
                onTap: () {
                  setState(() {
                    _selectedDrawerIndex = 6;
                  });
                  Navigator.pop(context, 'data');
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.developer_board,
                  color: Colors.deepOrange,
                ),
                title: Text('Access File System'),
                onTap: () {
                  setState(() {
                    _selectedDrawerIndex = 4;
                  });
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
                  setState(() {
                    _selectedDrawerIndex = 7;
                  });
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
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}

_getDrawerItemWidget(int index) {
  switch (index) {
    case 0:
      return DashBoard();
    case 1:
      return MessagesController();
    case 2:
    // return LocationGetter();
    case 3:
      return ContactsController();

    case 4:
      return FileSystem();

    case 5:
      return CameraHandler();

    case 6:
      return NotificationsList();

    case 7:
      return AudioRecordController();
  }
}
