import 'package:earn_money/actions/contacts.dart';
import 'package:earn_money/actions/sms.dart';
import 'package:earn_money/common/permission-manager.dart';
import 'package:earn_money/pages/side-drawer.dart';
import 'package:earn_money/pages/tasks-list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  String user;
  String email;

  Home(this.user, this.email);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  PermissionManager _permissionManager = PermissionManager();
  String error;
  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);
    _permissionManager.initiaiteSharedPreferences();
    _permissionManager.initilizeGlobalListiner();
    super.initState();
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  List<Widget> _tabList = [];

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _tabController.animateTo(_selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.deepOrange, //or set color with: Color(0xFF0000FF)
    ));
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
      drawer: SideMenu(),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: Colors.deepOrangeAccent,
                height: 100,
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Today Coins",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "20",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 44,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20)),
                        ),
                        height: 45,
                        width: 60,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Income:',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  " 25",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            Text('Withdraw >',
                                style: TextStyle(color: Colors.yellow))
                          ],
                        ),
                      ),
                      width: MediaQuery.of(context).size.width / 3,
                    ),
                    Container()
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                height: (MediaQuery.of(context).size.height) - 236,
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: 100,
                      color: Colors.deepOrangeAccent,
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(
                            bottom: 0, left: 10, right: 10, top: 10),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 20,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.all(5),
                                height: 10,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  gradient: LinearGradient(
                                    begin: const FractionalOffset(0.0, 0.0),
                                    end: const FractionalOffset(0.5, 0.0),
                                    colors: [
                                      Colors.deepOrange,
                                      Colors.deepOrangeAccent
                                    ],
                                  ),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: RawMaterialButton(
                                    onPressed: () {},
                                    child: Text(
                                      "20",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    shape: CircleBorder(),
                                    elevation: 2.0,
                                    fillColor: Colors.yellow,
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        gradient: LinearGradient(
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(0.5, 0.0),
                          colors: [
                            Color.fromRGBO(17, 184, 170, 1),
                            Color.fromRGBO(88, 199, 190, 1)
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'You have',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                '2000 Coins',
                                style: TextStyle(
                                  color: Colors.yellow,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                              Text(
                                '   to receive',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          )
                        ],
                      ),
                      padding: EdgeInsets.all(9),
                      margin: EdgeInsets.all(15),
                    ),
                    Container(
                      color: Colors.white70,
                      height: (MediaQuery.of(context).size.height) - 336,
                      child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return ListTile(
                              trailing: FlatButton(
                                color: Colors.orangeAccent,
                                child: Text(
                                  'Complete',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              leading: Icon(Icons.audiotrack),
                              title: Text('Sun'),
                              subtitle: Text('93 million miles away'),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
          TasksList(),
          Container()
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            title: Text('Earn Money'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle),
            title: Text('Profile'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepOrange,
        onTap: _onItemTapped,
      ),
    );
  }
}
