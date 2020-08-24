import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

class FailPage extends StatefulWidget {
  String mess;

  FailPage({this.mess});

  @override
  State<StatefulWidget> createState() {
    return _FailPageState();
  }
}

class _FailPageState extends State<FailPage> with WidgetsBindingObserver {
  @override
  Future<bool> didPopRoute() {
    Navigator.pop(context, "delegatecard");
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    Timer(new Duration(seconds: 3), () {
      Navigator.pop(context, "delegatecard");
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'THẤT BẠI',
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Color(0xff00B712),
                    Color(0xff5AFF15),
                  ])),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/error.png"),
            SizedBox(
              height: 20,
            ),
            Text(
              "${widget.mess}",
              style: TextStyle(fontSize: 22, color: Colors.green),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(100),
              ),
              height: 55,
              child: OutlineButton(
                color: Colors.green,
                textColor: Colors.white,
                borderSide: BorderSide(color: Colors.green, width: 2.0),
                highlightedBorderColor: Colors.green,
                splashColor: Colors.green,
                highlightColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0)),
                child: Text("Quay lại"),
                onPressed: () {
                  Navigator.pop(context, "delegatecard");
                  return;
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[50],
    );
  }
}
