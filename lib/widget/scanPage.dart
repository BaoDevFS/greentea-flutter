
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
class ScanCode extends StatefulWidget{
  int type;
  ScanCode({this.type});

  @override
  _ScanCodeState createState() {
    // TODO: implement createState
    return _ScanCodeState(type: type);
  }
}
class _ScanCodeState extends State<ScanCode>{
  int type;
  String barcode="";
  _ScanCodeState({this.type,this.barcode}){
   _scan();
  }
  Future _scan() async {
    String barcode = await scanner.scan();
    setState(() {
      this.barcode=barcode;
    });
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Center(child: CircularProgressIndicator(),);
  }

}