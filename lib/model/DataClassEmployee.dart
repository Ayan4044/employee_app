class DataClassEmployee {
  int? emoloyeeId;
  String? employeeName;
  String? employeeRole;
  String? employeeJoiningdate;
  String? employeeToDate;
  int? employeeType;

  DataClassEmployee(
      {this.emoloyeeId,
      this.employeeName,
      this.employeeRole,
      this.employeeJoiningdate,
      this.employeeToDate,
      this.employeeType});

  DataClassEmployee.fromJson(Map<String, dynamic> json) {
    emoloyeeId = json['_id'];
    employeeName = json['employee_name'];
    employeeRole = json['employee_role'];
    employeeJoiningdate = json['employee_joiningdate'];
    employeeToDate = json['employee_toDate'];
    employeeType = json['employee_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.emoloyeeId;
    data['employee_name'] = this.employeeName;
    data['employee_role'] = this.employeeRole;
    data['employee_joiningdate'] = this.employeeJoiningdate;
    data['employee_toDate'] = this.employeeToDate;
    data['employee_type'] = this.employeeType;
    return data;
  }

  DataClassEmployee.fromMap(Map<String, dynamic> result)
      : emoloyeeId = result["_id"],
        employeeName = result["employee_name"],
        employeeRole = result["employee_role"],
        employeeJoiningdate = result["employee_joiningdate"],
        employeeToDate = result["employee_toDate"],
        employeeType = result["employee_type"];

  Map<String, dynamic> toMap() {
    return {
      '_id': emoloyeeId,
      'employee_name': employeeName,
      'employee_role': employeeRole,
      'employee_joiningdate': employeeJoiningdate,
      'employee_toDate': employeeToDate,
      'employee_type': employeeType
    };
  }
}
