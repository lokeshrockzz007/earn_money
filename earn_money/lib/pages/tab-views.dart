import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class TabsView extends StatefulWidget {
  TabsView({Key key}) : super(key: key);

  @override
  _TabsViewState createState() => _TabsViewState();
}

class _TabsViewState extends State<TabsView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final titleController = TextEditingController();
  final messageController = TextEditingController();
  int userid = 1;
  bool loading = false;
  var usersInfo = [
    {
      "postId": 1,
      "id": 1,
      "name": "id labore ex et quam laborum",
      "title": "Eliseo@gardner.biz",
      "body":
          "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium"
    },
  ];
  List info = new List();

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  callGet() {
    showDialog(
        context: context,
        builder: (BuildContext builder) {
          return AlertDialog(
            title: Text('Alert'),
            content: Text('Will add new list to the list'),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.pop(context, {true});
                },
              )
            ],
          );
        }).then((response) => {});
  }

  getSpinner() {
    if (loading) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    }
  }

  addInfo(title, message) {
    setState(() {
      loading = true;
    });
    var url = 'https://jsonplaceholder.typicode.com/posts';
    var infobody = json.encode({'title': title, 'body': message});
    var test = http.post(url, body: infobody, headers: {
      "Content-type": "application/json; charset=UTF-8"
    }).then((response) {
      print(response.body);
      setState(() {
        loading = false;
      });
      usersInfo.add(
        json.decode(response.body),
      );
      print(usersInfo);
    }).catchError((onError) {
      print('some error occured');
    });
  }

  addUpdateDialog(isUpdate, index) {
    if (isUpdate) {
      setState(() {
        titleController.text = usersInfo[index]['title'];
        messageController.text = usersInfo[index]['body'];
      });
    } else {
      setState(() {
        titleController.text = '';
        messageController.text = '';
      });
    }

    showDialog(
        context: context,
        builder: (BuildContext builder) {
          return Dialog(
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    AppBar(
                      backgroundColor: Colors.deepOrange,
                      title: Text(isUpdate ? 'Update' : 'Add post'),
                    ),
                    Container(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Title'),
                          TextField(
                            controller: titleController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Please enter your titile'),
                          ),
                          SizedBox(height: 20),
                          Text('Message'),
                          TextField(
                            controller: messageController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Please enter your message'),
                          ),
                          SizedBox(height: 30),
                          Center(
                            child: RaisedButton(
                              color: Colors.deepOrangeAccent,
                              textColor: Colors.white,
                              child: Text(isUpdate ? 'Update' : 'Add post'),
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }).then((onValue) {
      if (onValue) {
        if (isUpdate) {
          setState(() {
            usersInfo[index]['title'] = titleController.text;
            usersInfo[index]['body'] = messageController.text;
          });
          updateInfo(index);
        } else {
          addInfo(titleController.text, messageController.text);
        }
      }
    });
  }

//delete service call
  removeElement(index) {
    var url = 'https://jsonplaceholder.typicode.com/posts/' +
        usersInfo[index]['id'].toString();
    setState(() {
      usersInfo.removeAt(index);
    });
    http
        .delete(url, headers: {'Content-Type': 'application/json'})
        .then((response) => {print('item removed')})
        .catchError((onError) => {print(onError)});
  }

  getData() {
    var url = 'https://jsonplaceholder.typicode.com/posts/' + userid.toString();
    setState(() {
      loading = true;
    });
    http
        .get(url, headers: {'Content-Type': 'application/json'})
        .then((response) => {
              setState(() {
                usersInfo.add(json.decode(response.body));
                loading = false;
                userid++;
              })
            })
        .catchError((onError) {
          print(onError);
          setState(() {
            loading = false;
          });
        });
  }

  updateInfo(index) {
    var url = 'https://jsonplaceholder.typicode.com/posts/' +
        usersInfo[index]['id'].toString();
    var body = json.encode(usersInfo[index]);
    http.put(url, body: body, headers: {
      "Content-type": "application/json; charset=UTF-8"
    }).then((response) => {print(response.body)});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBarView(controller: _tabController, children: <Widget>[
        Tab(
          child: Stack(
            children: <Widget>[
              loading
                  ? getSpinner()
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        print(index);
                        return Dismissible(
                          background: Container(
                            color: Colors.red,
                          ),
                          key: ObjectKey(usersInfo[index]['id']),
                          child: ListTile(
                              trailing: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  setState(() {});
                                  addUpdateDialog(true, index);
                                },
                              ),
                              title: Text(usersInfo[index]['title']),
                              subtitle: Text(usersInfo[index]['body'])),
                          onDismissed: (direction) {
                            removeElement(index);
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Item deleted"),
                              backgroundColor: Colors.deepOrangeAccent,
                              duration: Duration(milliseconds: 800),
                            ));
                          },
                        );
                      },
                      itemCount: usersInfo.length,
                    ),
            ],
          ),
        ),
        Tab(
          child: Center(
            child: Text('data'),
          ),
        ),
        Tab(
          child: Center(child: Text('text')),
        ),
      ]),
    );
  }
}
