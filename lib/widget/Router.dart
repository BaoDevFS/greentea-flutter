import 'package:flutter/material.dart';
import 'package:greentea/widget/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../define.dart';
import 'loginPage.dart';

class Router extends StatefulWidget {
  @override
  _RowterState createState() => _RowterState();
}

class _RowterState extends State<Router> {
  @override
  void initState() {
    getStatusLogin();
  }

  // kiem tra login hay chua
  void getStatusLogin() async {
    
    print("CALLBACK");
    final sharePreferent = await SharedPreferences.getInstance();
    final result = sharePreferent.getBool(Define.KEY_STATUSLOGIN) ?? false;
    if (!result) {
      // thay the page hien tai khong back ve  page Router() khi nhan nut back
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(title: "HomePage"),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Greentea"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ));
  }
}
