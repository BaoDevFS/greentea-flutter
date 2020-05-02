import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:greentea/model/units.dart';
import 'package:greentea/widget/scanPage.dart';
import 'package:http/http.dart' as http;

class SlectUnits extends StatefulWidget {
  String token;
  int type;

  SlectUnits({this.token, this.type});

  @override
  SlectUnitsState createState() => SlectUnitsState(token: token, type: type);
}

class SlectUnitsState extends State<SlectUnits> {
  Unit line;
  final String token;
  final int type;
  GlobalKey<ScaffoldState> _globalKey = new GlobalKey();
  // chua danh sach cac unit lay tu server
  List<Unit>  units= new List();

  final urlType1_2 = "http://youth.gtnlu.site/api/checkinglist";
  final urlType3 = "http://youth.gtnlu.site/api/program/checkinglist";

  SlectUnitsState({this.token, this.type});

  getUnits(int type) async {
    //type 3 la diem danh bang tay !=3 la diem danh bang scan
    http.Response response;
    if (type == 3) {
       response = await http.get(urlType3,
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    } else {
       response = await http.get(urlType1_2,
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    }
    if (json.decode(response.body).toString().endsWith("]")) {
      List<dynamic> list = json.decode(response.body);
      // cap nhat lai data cho dropdown
      setState(() {
        units = list.map((i) => Unit.fromJson(i)).toList();
      });
    } else {
      // khong du quyen show snackbar
      units.add(new Unit());
      _globalKey.currentState.showSnackBar(SnackBar(content:Text("YOU NOT HAVE PERMISSION")));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getUnits(type);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text("Units"),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.black12
          ),
          child: DropdownButton<Unit>(
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            hint: Text("Select units"),
            style: TextStyle(color: Colors.red),
            onChanged: (Unit value) {
              setState(() {
                line = value;
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>ScanCode(type: type,unit: line,token: token,)
                ));
              });
            },
            items: units.map<DropdownMenuItem<Unit>>((Unit value) {
              return DropdownMenuItem<Unit>(
                  value: value,
                  child: Text(value.name, style: TextStyle(color: Colors.black)));
            }).toList() ,
            value: line,
          ),
        ),
      ),
    );
  }
}
