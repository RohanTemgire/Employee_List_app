import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import '../models/employee.dart';

class Employees with ChangeNotifier {
  static Database? _database;

  final String tableEmployee = 'employees';
  final String id = 'id';
  final String name = 'name';
  final String age = 'age';
  final String gender = 'gender';
  final String yrsInOrganization = 'yrsInOrganization';
  final String isActive = 'isActive';

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + 'employeeList.db';

    var database =
        await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('''
        create table $tableEmployee (
          $id string primary key ,
          $name string not null,
          $age int not null,
          $gender string not null,
          $yrsInOrganization int not null,
          $isActive string not null)
        ''');
    });

    return database;
  }

  //storing data to the local database
  void insertEmployeeToDB(Employee employee) async {
    var db = await this.database;
    var result = db.insert(tableEmployee, employee.toMap());
    print(result);
  }

  //retriving data from local database
  Future<void> getEmployeeFromDB() async {
    List<Employee> _employeeDB = [];
    var db = await this.database;
    var result = await db.query(tableEmployee);
    result.forEach((element) {
      var employeeInfo = Employee.fromMap(element);
      _employeeDB.add(employeeInfo);
    });
    _employees = _employeeDB;
  }

  List<Employee> _employees = [];

  List<Employee> get getEmployees {
    return [..._employees];
  }

  final _url = Uri.parse(
      'https://zylu-business-solutions-default-rtdb.firebaseio.com/employees.json');


  //adding Employee to the server and to our database
  Future<void> addEmployee(Employee employee) async {
    String res = 'success';
    try {
      insertEmployeeToDB(employee);
      final data = await http.post(_url,
          body: json.encode({
            'name': employee.name,
            'age': employee.age,
            'gender': employee.gender,
            'yrsInOrganization': employee.yrsInOrganization,
            'isActive': employee.isActive
          }));

      final newEmployee = Employee(
          id: json.decode(data.body)['name'],
          name: employee.name,
          age: employee.age,
          gender: employee.gender,
          yrsInOrganization: employee.yrsInOrganization,
          isActive: employee.isActive);

      _employees.add(newEmployee);
      print(res);
      notifyListeners();
    } catch (e) {
      res = e.toString();
      print(res);
    }
  }


  //retriving data from the database
  Future<void> getEmployee() async {
    String res = 'success';
    try {
      //this code snipet is used to get the data from online database

      // final data = await http.get(_url);
      // var jsonData = json.decode(data.body) as Map<String, dynamic>;
      // final List<Employee> employees = [];
      // jsonData.forEach((key, value) {
      //   insertEmployeeToDB(Employee(
      //       id: key,
      //       name: value['name'],
      //       age: value['age'],
      //       gender: value['gender'],
      //       yrsInOrganization: value['yrsInOrganization'],
      //       isActive: value['isActive']));
      //   employees.add(Employee(
      //       id: key,
      //       name: value['name'],
      //       age: value['age'],
      //       gender: value['gender'],
      //       yrsInOrganization: value['yrsInOrganization'],
      //       isActive: value['isActive']));
      // });
      // _employees = employees.toList();

      await getEmployeeFromDB();
      // print(res);
      notifyListeners();
    } catch (err) {
      res = err.toString();
      // print(res);
    }
  }
}
