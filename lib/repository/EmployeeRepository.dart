import 'dart:convert';

import 'package:flutter/material.dart';

import '../database/DatabaseService.dart';
import '../model/DataClassEmployee.dart';

class EmployeeRepository {
  DatabaseService _dbService = DatabaseService();

  Future<int> getEmployeeCount() async {
    int count = await _dbService.getEmployeeCount();
    return count;
  }

  Future<List<DataClassEmployee>> getEmployeeType(int type) async {
    List<DataClassEmployee> _logEmployeeList = [];
    _logEmployeeList = (await _dbService.getCurrentEmployeeBytype(type))
        as List<DataClassEmployee>;
    debugPrint("LogList ${jsonEncode(_logEmployeeList)}");
    return _logEmployeeList;
  }

  Future<int> saveEnployee(DataClassEmployee employee) async {
    int response = await _dbService.insertEmployee(employee);
    return response;
  }

  Future<int> deleteEmployeeById(int empID) async {
    int response = await _dbService.deleteEmoloyee(empID);
    return response;
  }

  Future<DataClassEmployee> getLatestEntry() async {
    DataClassEmployee dataClassEmployee = DataClassEmployee();
    Map<String, dynamic>? query = await _dbService.selectLastRow();
    debugPrint("Last Row ${jsonEncode(query)}");
    if (query != null) {
      dataClassEmployee = DataClassEmployee.fromJson(query);
    }
    return dataClassEmployee;
  }
}
