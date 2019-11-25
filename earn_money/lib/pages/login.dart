import 'package:flutter/material.dart';

import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String errorMessage = "";
  String username = "";

  @override
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Container(
          color: Colors.white,
          height: 530.0,
          margin: EdgeInsets.only(top: 100, left: 20, right: 20),
          padding: EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                FlutterLogo(
                  size: 100,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Text(
                    errorMessage,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
                Text('Username'),
                Center(
                  child: TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                        labelText: 'Enter your email address',
                        hintText: 'test@services.com'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter email address';
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    textDirection: TextDirection.ltr,
                    autofocus: true,
                    maxLength: 25,
                  ),
                ),
                Text('Password'),
                Center(
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter password';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Enter your password', hintText: '********'),
                    keyboardType: TextInputType.text,
                    controller: passwordController,
                    textDirection: TextDirection.ltr,
                    obscureText: true,
                    autofocus: true,
                    maxLength: 10,
                  ),
                ),
                FlatButton(
                  child: Text('Login'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      if (usernameController.text == "test@test.com" &&
                          passwordController.text == '0000') {
                        username = "GGK Tech";
                        setState(() {
                          errorMessage = "";
                        });
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Home(username, usernameController.text)));
                      } else {
                        setState(() {
                          errorMessage = "Invalid username or password";
                        });
                      }
                    }
                  },
                  color: Colors.yellow,
                )
              ],
            ),
          )),
    );
  }
}
