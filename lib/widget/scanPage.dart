import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greentea/model/delegate.dart';
import 'package:greentea/model/units.dart';
import 'package:greentea/model/user.dart';
import 'package:greentea/widget/delegateCard.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:http/http.dart' as http;

class ScanCode extends StatefulWidget {
  int type;
  Unit unit;
  String token;

  ScanCode({this.type, this.unit, this.token});

  @override
  _ScanCodeState createState() {
    return _ScanCodeState(type: type, unit: unit, token: token);
  }
}

class _ScanCodeState extends State<ScanCode> with WidgetsBindingObserver {
  final int type;
  final Unit unit;
  final String token;
  String barcode ="", mesage;
  Delegate delegate;
  User user;
  var navigationResult=" ";

  _ScanCodeState({this.type, this.unit, this.token}) {
    print(token);
  }

  Future _scan() async {
    String barcode = await scanner.scan();
    this.barcode = barcode;
    getInforDelegate(type);
  }

  @override
  void initState() {
    _scan();
  }

  changePage(String type, bool _bool) async {
    // is checkingmanual
    if (type == 'checkinManual') {
      if (_bool) {
        print("ckecinManutrue");
      } else {
        print("ckecinManualFALSE");
      }
      return;
    }
    if (_bool) {
      navigationResult = await Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) =>
                  DelegateCard(mess: mesage, instance: delegate)));
      print("ckecintrue");
    } else {
//      navigationResult= await Navigator.push(
//          context, new MaterialPageRoute(builder: (context) => ));
      print("ckecinFALSE");
    }
  }

  getInforDelegate(int type) {
    switch (type) {
      case 1:
        checkin('checkin');
        break;
      case 2:
        checkin('checkout');
        break;
      case 3:
        checkinManual();
        break;
    }
  }

  //checkin or checkout dua vao type truyen vao
  checkin(String type) async {
    var uri;
    final tmp = barcode;
    setState(() {
      barcode=null;
    });
    if (type == "checkin") {
      print("ischeckIn" + tmp + "${unit.id}");
//      url = 'http://youth.gtnlu.site/api/checkin?data=$tmp&id=${unit.id}';
      uri = Uri.http('youth.gtnlu.site', 'api/checkin',
          {'data': tmp, 'id': '${unit.id}'});
    } else {
      print("ischeckOut" + tmp + "${unit.id}");
//      url = 'http://youth.gtnlu.site/api/checkout?data=$tmp&id=${unit.id}';
      uri = Uri.http('youth.gtnlu.site', 'api/checkout',
          {'data': tmp, 'id': '${unit.id}'});
    }

    final response = await http
        .get(uri, headers: {HttpHeaders.authorizationHeader: "Bearer $token"});

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      print(body);
      // {status: 200, code: 1, mes: Đại biểu đã điểm danh, chào mừng Đồng chí, member: {id: 208, name: Nguyễn Nguyễn, avatar: null, class: DH17DT, iddep: 1, depsname: Khoa Lâm Nghiệp, col: 1, row: 1}}
      if (body['status'] == 200) {
        delegate = Delegate.fromJson(body['member']);
        mesage = body['mes'];
        print("mesage:" + mesage);
        changePage(type, true);
      } else {
        mesage = body['mes'];
        print("mesage:" + mesage);
        changePage(type, false);
      }
    } else {
      mesage = "SERVER EROR";
      print("mesage:" + mesage);
      changePage(type, false);
    }
  }

  checkinManual() async {
    final tmp = barcode;
    setState(() {
      barcode=null;
    });
    var uri = Uri.http('youth.gtnlu.site', '/api/program/checkin',
        {'id': '${unit.id}', 'idNlu': tmp});
    final response = await http
        .get(uri, headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      if (body['status'] == 200) {
        user = User(
          iddep: body['user']['idp'],
          idNlu: body['user']['idNlu'],
        );
        mesage = body['mes'];
        print("mesage:" + mesage);
        changePage('checkinManual', true);
      } else {
        mesage = body['mes'];
        print("mesage:" + mesage);
        changePage('checkinManual', false);
      }
    } else {
      mesage = "SERVER EROR";
      print("mesage:" + mesage);
      changePage('checkinManual', false);
    }
  }

//  @override
//  void deactivate() {
//    print("deactivate");
//  } //  GlobalKey<>

  @override
  Widget build(BuildContext context) {
    // đc back từ màn hình thành công về thì quét tiếp
    //dang load data tu server
    if(barcode ==  null&&navigationResult == " "){
      return Center(
        child: CircularProgressIndicator(),
      );
      // dc back ve tiep tuc scan
    }else if (navigationResult == "delegatecard" && barcode==null) {
      _scan();
      navigationResult = " ";
      return Scaffold(
        appBar: AppBar(
          title: Text("Sanner"),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Tiếp tục quét",
                      style: TextStyle(fontSize: 15,),
                    ),
                  ),
                  onPressed: (){
                      _scan();
                  },
                ),
                FlatButton(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Trở về",
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
              ]),
        ),
      );
    }else{
      return Scaffold(
        appBar: AppBar(
          title: Text("Sanner"),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Tiếp tục quét",
                      style: TextStyle(fontSize: 15,),
                    ),
                  ),
                  onPressed: (){
                      _scan();
                  },
                ),
                FlatButton(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Trở về",
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
              ]),
        ),
      );
    }

  }
}
