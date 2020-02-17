class Department{
  String name;
  String code;

  @override
  String toString() {
    return '{name: $name, code: $code}';
  }

  Department({this.name, this.code});
  factory Department.fromJson(Map<String,dynamic> json){
    return  Department(
      name: json['name'],
      code: json['code']
    );
  }

}