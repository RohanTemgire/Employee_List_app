import 'package:flutter/cupertino.dart';

class Employee with ChangeNotifier {
  String id;
  String name;
  int age;
  String gender;
  int yrsInOrganization;
  String isActive;

  Employee(
      {required this.id,
      required this.name,
      required this.age,
      required this.gender,
      required this.yrsInOrganization,
      required this.isActive});

  factory Employee.fromMap(Map<String, dynamic> json) => Employee(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      gender: json['gender'],
      yrsInOrganization: json['yrsInOrganization'],
      isActive: json['isActive']);

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'age': age,
        'gender': gender,
        'yrsInOrganization': yrsInOrganization,
        'isActive': isActive
      };
}
