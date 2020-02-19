import 'department.dart';
class User{
  final int id;
  final String idNlu;
  final String name;
  final int iddep;
  final String classroom;
  final String job;
  final String gender;
  final String phone;
  final int group;
  final Department dep;

  User({this.id, this.idNlu, this.name, this.iddep, this.classroom, this.job,
      this.gender, this.phone, this.group, this.dep});

  @override
  String toString() {
    return '{id: $id, idNlu: $idNlu, name: $name, iddep: $iddep, classroom: $classroom, job: $job, gender: $gender, phone: $phone, group: $group, dep: $dep}';
  }

  factory User.fromJson(Map<String,dynamic> json){
    return User(
      id: json['id'],
      idNlu: json['idNlu'],
      name: json['name'],
      iddep: json['iddep'],
      classroom: json['class'],
      job: json['job'],
      gender: json['gender'],
      phone: json['phone'],
      group: json['group'],
      dep: Department.fromJson(json['dep'])
    );
  }

}