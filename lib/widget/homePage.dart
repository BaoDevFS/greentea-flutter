import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greentea/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginPage.dart';
import '../define.dart';
import 'select_unit.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class   _MyHomePageState extends State<MyHomePage> {
  String token = "";
  User user = new User(name: "", idNlu: "");
  getTokenFromSharePrefer() async {   
    final sharePreferent = await SharedPreferences.getInstance();
    token = sharePreferent.getString(Define.KEY_TOKEN ?? "");
    setState(() {
      user =
          User.fromJson(json.decode(sharePreferent.get(Define.KEY_USER ?? "")));
    });
    if (token == "") {
      sharePreferent.setBool(Define.KEY_STATUSLOGIN, false);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ));
    }
  }

  logout() async {
    final sharePreferent = await SharedPreferences.getInstance();
    sharePreferent.setBool(Define.KEY_STATUSLOGIN, false);
    sharePreferent.remove(Define.KEY_TOKEN);
    // ve man hinh login khog quay tro lai dc
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ));
  }

  @override
  void initState() {
    getTokenFromSharePrefer();
  }

  Widget _divider() {
    return Container(
      height: 15,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 1, color: Colors.black, style: BorderStyle.solid))),
    );
  }

  bool _checkIsNumber(number) {
    try {
      int.parse(number);
      return true;
    } catch (er) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            FlatButton(
              child: Text("Checkin"),
              color: Colors.blue,
              textColor: Colors.white,
              disabledColor: Colors.blue,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: () {
                if (token != "" || token == 'null') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SlectUnits(
                          token: token,
                          type: Define.TYPESCAN_CHECKIN,
                        ),
                      ));
                }
              },
            ),
            FlatButton(
              child: Text("Checkout"),
              color: Colors.blue,
              textColor: Colors.white,
              disabledColor: Colors.blue,
              padding: EdgeInsets.all(8.0),
              onPressed: () {
                if (token != "") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SlectUnits(
                          token: token,
                          type: Define.TYPESCAN_CHECKOUT,
                        ),
                      ));
                }
              },
            ),
            FlatButton(
              child: Text("Attendance"),
              color: Colors.blue,
              textColor: Colors.white,
              disabledColor: Colors.blue,
              padding: EdgeInsets.all(8.0),
              onPressed: () {
                if (token != "") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SlectUnits(
                          token: token,
                          type: Define.TYPESCAN_CHECKMANUAL,
                        ),
                      ));
                }
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text(
                  '${_checkIsNumber(user.idNlu) ? user.idNlu + "@hcmuaf.edu.vn" : user.idNlu + "@gmail.com"}'),
              accountName: Text('${user.name}'),
              decoration: BoxDecoration(color: Colors.green),
              currentAccountPicture: CircleAvatar(
                child: Image.asset(
                  "assets/images/facebook.png",
                ),
                backgroundColor: Colors.green,
              ),
            ),
            _divider(),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(
                    Icons.details,
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text("About")
                ],
              ),
              onTap: () {},
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(
                    Icons.forward,
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text('Logout')
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                logout();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.add),
        onPressed: () {
          logout();
        },
      ),
    );
  }
}
