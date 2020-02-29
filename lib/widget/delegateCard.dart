import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:greentea/model/delegate.dart';

class DelegateCard extends StatelessWidget {
  final String mess;
  final Delegate instance;

  const DelegateCard({this.mess, this.instance});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'THẺ ĐẠI BIỂU',
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
        body: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ListView(
            children: <Widget>[
              showInfo(context),
            ],
          ),
        ),
        backgroundColor: Colors.grey[50],
      ),
    );
  }

  Widget showInfo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            child: Image.asset('assets/images/avt.png'),
            radius: 78,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              instance.name,
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: Colors.grey[850]),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: Text(
              instance.depname,
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Container(
              width: 180,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 7,
                      // offset: Offset(0, 0),
                      color: Color(000).withOpacity(.4),
                      spreadRadius: 0)
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 1, 3, 0),
                        child: Icon(
                          Icons.event_seat,
                          size: 18,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        'Vị trí chỗ ngồi',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  Text(
                    '${instance.row}-${instance.col}',
                    style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        color: Color(0xffF53803)),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Text(
              mess,
              style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w400,
                  color: Colors.blue),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
            width: 200,
            height: 60,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xff00B712),
                    Color(0xff5AFF15),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[500],
                    blurRadius: 5,
                  ),
                ],
                borderRadius: BorderRadius.circular(30)),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Xác nhận',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
