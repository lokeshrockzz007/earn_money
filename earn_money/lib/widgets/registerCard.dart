import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterCard extends StatelessWidget {
  final primaryColors = [Colors.orangeAccent, Colors.deepOrangeAccent];
  SharedPreferences sharedPreference;
  bool _isGoldMembership = false;
  RegisterCard(this._isGoldMembership);
  initilizeSharedPreference() async {
    sharedPreference = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    initilizeSharedPreference();
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage("assets/logo.png"),
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.1), BlendMode.dstATop),
            fit: BoxFit.none,
          ),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0),
          ]),
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(_isGoldMembership ? "Gold Sign Up" : "Sign Up",
                style: TextStyle(
                    color: primaryColors[1],
                    fontSize: ScreenUtil.getInstance().setSp(45),
                    fontFamily: "Poppins-Bold",
                    letterSpacing: .6)),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text("Username",
                style: TextStyle(
                    color: Colors.deepOrange,
                    fontFamily: "Poppins-Medium",
                    fontSize: ScreenUtil.getInstance().setSp(22))),
            TextField(
              onChanged: (value) {
                sharedPreference.setString('username', value.toString());
              },
              decoration: InputDecoration(
                  hintText: "username",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0)),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text("Password",
                style: TextStyle(
                    color: Colors.deepOrange,
                    fontFamily: "Poppins-Medium",
                    fontSize: ScreenUtil.getInstance().setSp(22))),
            TextField(
              obscureText: true,
              onChanged: (value) {
                sharedPreference.setString('password', value.toString());
              },
              decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0)),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(35),
            ),
            Text("Email Address",
                style: TextStyle(
                    color: Colors.deepOrange,
                    fontFamily: "Poppins-Medium",
                    fontSize: ScreenUtil.getInstance().setSp(22))),
            TextField(
              onChanged: (value) {
                sharedPreference.setString('email', value.toString());
              },
              decoration: InputDecoration(
                  hintText: "Email Address",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0)),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text("Mobile",
                style: TextStyle(
                    color: Colors.deepOrange,
                    fontFamily: "Poppins-Medium",
                    fontSize: ScreenUtil.getInstance().setSp(22))),
            TextField(
              onChanged: (value) {
                sharedPreference.setString('mobile', value.toString());
              },
              decoration: InputDecoration(
                  hintText: "Mobile",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0)),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(60),
            ),
            _isGoldMembership
                ? Container()
                : Text("Reference Code",
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontFamily: "Poppins-Medium",
                        fontSize: ScreenUtil.getInstance().setSp(22))),
            _isGoldMembership
                ? Container()
                : TextField(
                    onChanged: (value) {
                      sharedPreference.setString('refCode', value.toString());
                    },
                    decoration: InputDecoration(
                        hintText: "Reference Code",
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 14.0)),
                  ),
            _isGoldMembership
                ? Container()
                : SizedBox(
                    height: ScreenUtil.getInstance().setHeight(60),
                  ),
          ],
        ),
      ),
    );
  }
}
