import 'package:flutter/foundation.dart';

import '../model/DataClassEmployee.dart';
import '../repository/EmployeeRepository.dart';

class EmployeeViewModel with ChangeNotifier {
  final _employeeRepo = EmployeeRepository();

  String _selectedDate = "";

  String get getselectedDate => _selectedDate;

  setSelectedDate(String date) {
    _selectedDate = date;
    debugPrint("Selected Date $_selectedDate");
    notifyListeners();
  }

  int _lastEmpoyee = 0;
  int get getLastEmployee => _lastEmpoyee;

  List<DataClassEmployee> employeeListcurrent = [];

  List<DataClassEmployee> employeeListLeft = [];

  List<DataClassEmployee> get getEmployeeListleft => employeeListLeft;

  int _employeeCount = 0;

  List<DataClassEmployee> get getEmployeeListCurrent => employeeListcurrent;
  bool _showDate = false;

  int get getEmployeeCount => _employeeCount;

  bool get getDataLength => _showDate;

  checkListLength() {
    debugPrint("is empty ${getEmployeeListCurrent.length}");
    if (employeeListcurrent.isEmpty) {
      _showDate = false;
    } else {
      _showDate = true;
    }
    notifyListeners();
  }

  loadEmployees(int type) async {
    employeeListcurrent = await loadEmployeeByType(type);
    notifyListeners();
  }

  loadEmployeesExpired(int type) async {
    employeeListLeft = await loadEmployeeByType(type);
    notifyListeners();
  }

  addNewEmployee(DataClassEmployee dataClassEmployee) {
    employeeListcurrent.add(dataClassEmployee);

    notifyListeners();
  }

  removeEmployee(DataClassEmployee dataClassEmployee) {
    employeeListcurrent.remove(dataClassEmployee);

    notifyListeners();
  }

  loadEmployeeCount() async {
    _employeeCount = await loadRowCount();
    notifyListeners();
  }

  Future<int> loadRowCount() async {
    int count = await _employeeRepo.getEmployeeCount();
    // noteList
    debugPrint("Note List $count");
    return count;
  }

  Future<List<DataClassEmployee>> loadEmployeeByType(int type) async {
    List<DataClassEmployee> loadEmployees =
        await _employeeRepo.getEmployeeType(type);
    // noteList
    debugPrint("Employee List $loadEmployees");
    return loadEmployees;
  }

  Future<void> saveEmployee(DataClassEmployee employee) async {
    int response = await _employeeRepo.saveEnployee(employee);
    debugPrint('Insert Response $response');
    if (response == 0) {
      debugPrint("Data Insertion Failed!!");
    } else if (response == 1) {
      debugPrint("Data Inserted!!");
    } else {
      debugPrint("Data Insertion Failed!!");
    }
  }

  Future<void> deleteEmployee(int id) async {
    int response = await _employeeRepo.deleteEmployeeById(id);
    if (response == 0) {
      debugPrint("Data Deletion Failed!!");
    } else if (response == 1) {
      debugPrint("Data Deleted!!");
    } else {
      debugPrint("Data Deleted Failed!!");
    }
  }

  Future<void> deleteLatestEntry() async {
    DataClassEmployee dataClassEmploye = await _employeeRepo.getLatestEntry();
    debugPrint("New Employee ID ${dataClassEmploye.emoloyeeId}");
    deleteEmployee(dataClassEmploye.emoloyeeId ?? 0);
  }
}
