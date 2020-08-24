import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:greentea/model/user.dart';

class SuccessPage extends StatelessWidget {
  final String mess;
  final User user;

  const SuccessPage({this.mess, this.user});

  @override
  Widget build(BuildContext context) {
//    Timer(new Duration(seconds: 2), () {
//      Navigator.pop(context, "delegatecard");
//    });
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'THÀNH CÔNG',
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
        body: WillPopScope(
          onWillPop: (){
            Navigator.pop(context, "delegatecard");
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset("assets/images/tick.png"),
                SizedBox(height: 20,),
                Text("${mess}",style: TextStyle(fontSize: 22,color: Colors.green),),
                SizedBox(height: 20,),
                Text("Chào ${user.idNlu}",style: TextStyle(fontSize: 20,color: Colors.red),textAlign: TextAlign.center,),
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
        ),
        backgroundColor: Colors.grey[50],
      ),
    );
  }
}
