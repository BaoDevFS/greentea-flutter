import 'package:flutter/material.dart';
class SlectUnits extends StatefulWidget{
  @override
  SlectUnitsState createState() => SlectUnitsState();
}
class SlectUnitsState extends State<SlectUnits>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    String line;
    return Scaffold(
      appBar: AppBar(
        title: Text("Units"),
      ),
      body: Center(
        child: DropdownButton<String>(
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 24,
          hint: Text("Select units"),
          style: TextStyle(
            color: Colors.red
          ),underline: Container(
          height: 2,
          color: Colors.deepPurple,
        ),
          onChanged: (String value){
            setState(() {
              line=value;
              print(value);
            });
          },items: <String>['One', 'Two', 'Free', 'Four'].map<DropdownMenuItem<String>>(
            (String value){
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style:  TextStyle(color: Colors.black))
              );
            }
        ).toList(),
          value: line,
        ),
      ),
    );
  }

}