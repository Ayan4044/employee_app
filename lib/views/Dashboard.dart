import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../resource/AppCaptions.dart';
import '../routes/Routenames.dart';
import '../utils/StatefulWrapper.dart';
import '../viewmodel/EmployeeViewModel.dart';

// class Dashboard extends StatefulWidget {
//   _DashboardState createState() => _DashboardState();
// }

class Dashboard extends StatelessWidget {
  final _employemodel = EmployeeViewModel();
  bool length = false;

  // @override
  // void initState() {
  //   super.initState();

  //   //_dashboardViewModel.setEncryptedData();
  //   // _dashboardViewModel.fetchDoctorProfile(context);
  //   //_employemodel.checkListLength();

  //   //debugPrint("Employee Lenght: ${_employemodel.getEmployeeList.length}");
  //   // if (_employemodel.getEmployeeList.length == 0) {
  //   //   length = false;
  //   // } else {
  //   //   length = true;
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    final employeeviewModel = Provider.of<EmployeeViewModel>(context);
    debugPrint("Length ${employeeviewModel.getEmployeeListCurrent.length}");
    return StatefulWrapper(
      onInit: () {
        employeeviewModel.loadEmployeeCount();
        employeeviewModel.loadEmployees(1);
        employeeviewModel.loadEmployeesExpired(2);

        debugPrint("Employee Count ${employeeviewModel.getEmployeeCount}");
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppCaptions.employeeList),
        ),
        body: ChangeNotifierProvider<EmployeeViewModel>(
          create: (BuildContext context) => employeeviewModel,
          child: Consumer<EmployeeViewModel>(builder: ((context, value, child) {
            debugPrint("Data ${employeeviewModel.getEmployeeCount}");
            if (employeeviewModel.getEmployeeCount == 0) {
              return const Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image(
                      image: AssetImage('assets/images/folder.png'),
                      width: 150.0,
                      height: 150.0),
                  Text("No Record Availabe!!",
                      style: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.bold)),
                ],
              ));
            } else {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("Current Employees",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    ),
                    Flexible(
                      child: Container(
                          color: Colors.white54,
                          child: ListView.builder(
                              itemCount: employeeviewModel
                                  .getEmployeeListCurrent.length,
                              itemBuilder: (BuildContext context, int index) {
                                var article = employeeviewModel
                                    .getEmployeeListCurrent[index];
                                return Dismissible(
                                  confirmDismiss: (direction) async {
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      bool delete = true;
                                      employeeviewModel.deleteEmployee(
                                          article.emoloyeeId ?? 0);
                                      final snackbarController =
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Deleted ${article.employeeName}'),
                                        ),
                                      );
                                      await snackbarController.closed;
                                      return delete;
                                    }

                                    return true;
                                  },
                                  background: dismissableBackground(),
                                  onDismissed: (_) {
                                    // setState(() {
                                    //   employeeviewModel.getEmployeeList
                                    //       .removeAt(index);
                                    // });
                                  },
                                  key: Key(employeeviewModel
                                          .getEmployeeListCurrent[index]
                                          .employeeName ??
                                      ""),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    elevation: 0.5,
                                    child: Container(
                                        //height: 100,
                                        margin: const EdgeInsets.all(8),
                                        child: Row(
                                          children: <Widget>[
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    article.employeeName ?? "",
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    article.employeeRole ??
                                                        "QA",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "From ${article.employeeJoiningdate}",
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                );
                              })),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("Previous Employees",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    ),
                    Flexible(
                      child: Container(
                          color: Colors.white54,
                          child: ListView.builder(
                              itemCount:
                                  employeeviewModel.getEmployeeListleft.length,
                              itemBuilder: (BuildContext context, int index) {
                                var article = employeeviewModel
                                    .getEmployeeListleft[index];
                                return Dismissible(
                                  confirmDismiss: (direction) async {
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      bool delete = true;
                                      employeeviewModel.deleteEmployee(
                                          article.emoloyeeId ?? 0);
                                      final snackbarController =
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Deleted ${article.employeeName}'),
                                        ),
                                      );
                                      await snackbarController.closed;
                                      return delete;
                                    }

                                    return true;
                                  },
                                  background: dismissableBackground(),
                                  onDismissed: (_) {
                                    // setState(() {
                                    //   employeeviewModel.getEmployeeList
                                    //       .removeAt(index);
                                    // });
                                  },
                                  key: Key(employeeviewModel
                                          .getEmployeeListleft[index]
                                          .employeeName ??
                                      ""),
                                  child: GestureDetector(
                                    // onTap: () => selectItem(article),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                      elevation: 0.5,
                                      child: Container(
                                          //height: 100,
                                          margin: const EdgeInsets.all(8),
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      article.employeeName ??
                                                          "",
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      article.employeeRole ??
                                                          "",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Text(
                                                          "${article.employeeJoiningdate}",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        const Text("-"),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          "${article.employeeToDate}",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),
                                );
                              })),
                    ),
                    const Spacer(),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Text('Swife Left to Delete'),
                        ),
                        Spacer(),
                      ],
                    ),
                  ]);
            }
          })),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Future.delayed(const Duration(milliseconds: 600), () {
              Navigator.pushNamed(context, Routenames.addEmployee);
            });
          },
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget dismissableBackground() {
    return Container(
      color: Colors.red,
      child: const Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
