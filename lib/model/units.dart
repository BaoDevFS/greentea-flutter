class Unit{
  final int id;
  final String name;
  Unit({this.id, this.name});
  factory Unit.fromJson(Map<String,dynamic> json){
    return Unit(
      id: json['id'],
      name: json['name']
    );
  }

  @override
  String toString() {
    return '{id: $id, name: $name}';
  }

}