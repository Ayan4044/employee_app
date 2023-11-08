import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/DataClassEmployee.dart';

class DatabaseService {
  static DatabaseService? databaseService;

  static Database? _database;

  //table details

  String _tableName = "employee_record";

  String _colID = "_id";

  String _employeeName = "employee_name";
  String _employeeRole = "employee_role";
  String _employeeJoiningdate = "employee_joiningdate";
  String _employeetoDate = "employee_toDate";
  String _employeeType = "employee_type";

  Future<Database> initializedDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'employee.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE $_tableName($_colID INTEGER PRIMARY KEY AUTOINCREMENT , $_employeeName TEXT NOT NULL,$_employeeRole TEXT NOT NULL, $_employeeJoiningdate TEXT NOT NULL, $_employeetoDate TEXT NOT NULL, $_employeeType INTEGER NOT NULL )",
        );
      },
    );
  }

  // insert data
  Future<int> insertEmployee(DataClassEmployee employee) async {
    int result = 0;
    final Database db = await initializedDB();

    debugPrint("Movies ${jsonEncode(employee)}");
    result = await db.insert(_tableName, employee.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return result;
  }

  Future<List<DataClassEmployee>> getEmployeeListByType(int type) async {
    final Database db = await initializedDB();

    final List<Map<String, Object?>> queryResult = await db
        .rawQuery('SELECT * FROM $_tableName WHERE $_employeeType=?', [type]);

    return queryResult.map((e) => DataClassEmployee.fromMap(e)).toList();
  }

  //delete operation:
  Future<int> deleteEmoloyee(int emoloyeeId) async {
    final Database db = await initializedDB();
    int res = await db
        .rawDelete("DELETE FROM $_tableName WHERE $_colID= $emoloyeeId");
    return res;
  }

  Future<int> getEmployeeCount() async {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult = await db.query(_tableName);
    return queryResult.length;
  }

  Future<List> getCurrentEmployeeBytype(int type) async {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult = await db
        .rawQuery('SELECT * FROM $_tableName WHERE $_employeeType=?', [type]);
    //return queryResult;
    debugPrint("Employee Type: ${jsonEncode(queryResult)}");
    return List<DataClassEmployee>.generate(queryResult.length,
        (index) => DataClassEmployee.fromMap(queryResult[index]),
        growable: true);
  }

  // Future<DataClassEmployee> getLatestEmployee() async {
  //   final Database db = await initializedDB();
  //   final List<Map<String, Object?>> queryResult =
  //       await db.rawQuery("SELECT max($_colID) FROM $_tableName");
  // }

  Future<Map<String, dynamic>?> selectLastRow() async {
    // Open the database
    final Database db = await initializedDB();

    // Query the table, ordering by 'id' in descending order and limit to one row.
    final List<Map<String, dynamic>> rows = await (db).query(
      '$_tableName',
      orderBy: '$_colID DESC',
      limit: 1,
    );

    // Check if there is a result and return it
    if (rows.isNotEmpty) {
      return rows.first;
    } else {
      return null; // No rows found
    }
  }
}
