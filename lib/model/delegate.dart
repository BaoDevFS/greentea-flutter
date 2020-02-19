class Delegate{
   int id;
   String name;
   String classRoom;
   String depname;
   int iddep;
   String avatar;
   int col;
   int row;

   Delegate({this.id, this.name, this.classRoom, this.depname, this.iddep,
       this.avatar, this.col, this.row});
   factory Delegate.fromJson(Map<String,dynamic> json){
     return Delegate(
       id: json['id'],
       name: json['name'],
       classRoom: json['class'],
       depname: json['depsname'],
       iddep: json['iddep'],
       avatar:json['avavtar'],
       col: json['col'],
       row: json['row']
     );
   }

}