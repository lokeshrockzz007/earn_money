import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earn_money/AdminPages/host-home.dart';
import 'package:earn_money/constants/constants.dart';
import 'package:earn_money/modals/CustomIcons.dart';
import 'package:earn_money/modals/users.dart';
import 'package:earn_money/widgets/loginCard.dart';
import 'package:earn_money/widgets/registerCard.dart';
import 'package:earn_money/widgets/socialIcons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSelected = false;
  bool _isLogin = true;
  bool _isGoldmembership = false;
  Users user;
  SharedPreferences _sharedPreferences;
  Firestore db = Firestore.instance;

  final primaryColors = [Colors.orangeAccent, Colors.deepOrangeAccent];

  String errorMessage = "";

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  void initState() {
    super.initState();
    initilizeSharedPreference();
  }

  initilizeSharedPreference() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  signUp() {
    user = Users(
        status: 'Pending',
        username: _sharedPreferences.getString('username'),
        userId: Random.secure().nextInt(100000).toString(),
        password: _sharedPreferences.getString('password'),
        mobile: _sharedPreferences.getString('mobile'),
        email: _sharedPreferences.getString('email'),
        userType: _isGoldmembership ? 'Gold' : 'Normal',
        createDate: DateTime.now().toString());
    user.refCode = _isGoldmembership
        ? user.userId
        : _sharedPreferences.getString('refCode');
    db
        .collection(FirebaseTables.Users)
        .document(user.userId)
        .setData(user.toJson())
        .then((onValue) {
      if (_isGoldmembership) {
        showGoldAccountRegistrationDialog();
      } else {
        db
            .collection(FirebaseTables.Users)
            .document(user.refCode)
            .updateData({'refCode': user.userId});
      }
      setState(() {
        _isLogin = !_isLogin;
      });
    });
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.deepOrangeAccent,
      ),
    );
  }

  showGoldAccountRegistrationDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Message'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Dear ${user.username} , you are successfully registred for the gold membership. We will send to the confirmation email to ${user.email} with the UPIN  after verification is completed'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  login() async {
    QuerySnapshot result = await db
        .collection(FirebaseTables.Users)
        .where("email", isEqualTo: _sharedPreferences.getString('email'))
        .where("password", isEqualTo: _sharedPreferences.getString('password'))
        .getDocuments();
    if (result.documents.length == 0) {
      errorMessage = Constants.ERROR_MESSAGE;
    } else {
      Users userInfo = Users.fromJson(result.documents.first.data);
      _sharedPreferences.setString('user_id', userInfo.userId);
      _sharedPreferences.setString('username', userInfo.username);
      _sharedPreferences.setString('password', userInfo.password);
      _sharedPreferences.setString('email', userInfo.email);
      _sharedPreferences.setString('refCode', userInfo.refCode);
      _sharedPreferences.setString('userType', userInfo.userType);

      if (userInfo.userType == Constants.GOLD_USER) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HostHome(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                Home(userInfo.username, userInfo.email),
          ),
        );
      }
    }
  }

  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: Colors.deepOrange)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.deepOrangeAccent),
              )
            : Container(),
      );

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Image.asset("assets/image_04.png"),
              ),
              Expanded(
                child: Container(),
              ),
              Image.asset("assets/image_02.png")
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/logo.png",
                        width: ScreenUtil.getInstance().setWidth(110),
                        height: ScreenUtil.getInstance().setHeight(110),
                      ),
                      Text("Earn Money",
                          style: TextStyle(
                              color: Color.alphaBlend(
                                  Colors.black12, Colors.black45),
                              fontFamily: "Poppins-Bold",
                              fontSize: ScreenUtil.getInstance().setSp(46),
                              letterSpacing: .6,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(180),
                  ),
                  _isLogin ? LoginCard() : RegisterCard(_isGoldmembership),
                  SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _isLogin
                          ? Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 12.0,
                                ),
                                GestureDetector(
                                  onTap: _radio,
                                  child: radioButton(_isSelected),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Text("Remember me",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "Poppins-Medium"))
                              ],
                            )
                          : Container(),
                      InkWell(
                        child: Container(
                          width: ScreenUtil.getInstance().setWidth(330),
                          height: ScreenUtil.getInstance().setHeight(100),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: primaryColors),
                              borderRadius: BorderRadius.circular(6.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFF6078ea).withOpacity(.3),
                                    offset: Offset(0.0, 8.0),
                                    blurRadius: 8.0)
                              ]),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                _isLogin ? login() : signUp();
                                // Navigator.pushReplacement(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (BuildContext context) => _isLogin
                                //         ? HostHome()
                                //         : Home(
                                //             "Username", "Username@gmail.com"),
                                //   ),
                                // );
                              },
                              child: Center(
                                child: Text(
                                    _isLogin
                                        ? "SIGNIN"
                                        : _isGoldmembership
                                            ? "REGISTER"
                                            : "SIGNUP",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins-Bold",
                                        fontSize: 18,
                                        letterSpacing: 1.0)),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      horizontalLine(),
                      Text("Social Login",
                          style: TextStyle(
                              fontSize: 16.0, fontFamily: "Poppins-Medium")),
                      horizontalLine()
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SocialIcon(
                        colors: primaryColors,
                        iconData: CustomIcons.facebook,
                        onPressed: () {},
                      ),
                      SocialIcon(
                        colors: primaryColors,
                        iconData: CustomIcons.googlePlus,
                        onPressed: () {},
                      ),
                      SocialIcon(
                        colors: primaryColors,
                        iconData: CustomIcons.twitter,
                        onPressed: () {},
                      ),
                      SocialIcon(
                        colors: primaryColors,
                        iconData: CustomIcons.linkedin,
                        onPressed: () {},
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        _isLogin ? "New User? " : "Already have account?",
                        style: TextStyle(fontFamily: "Poppins-Medium"),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _isGoldmembership = false;
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(_isLogin ? "SignUp" : "SignIn",
                            style: TextStyle(
                                color: primaryColors[1],
                                fontFamily: "Poppins-Bold")),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        _isLogin ? "SignUp for " : "",
                        style: TextStyle(fontFamily: "Poppins-Medium"),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _isGoldmembership = true;
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(_isLogin ? "Gold Membership" : "",
                            style: TextStyle(
                                color: primaryColors[1],
                                fontFamily: "Poppins-Bold")),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
