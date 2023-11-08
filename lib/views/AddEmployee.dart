import 'dart:convert';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:employee_app/model/DataClassEmployee.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../resource/AppCaptions.dart';
import '../routes/Routenames.dart';
import '../utils/CustomFunction.dart';
import '../utils/PrimaryButton.dart';
import '../utils/SecondaryButton.dart';
import '../viewmodel/EmployeeViewModel.dart';

class AddEmployee extends StatefulWidget {
  _AddEmployee createState() => _AddEmployee();
}

class _AddEmployee extends State<AddEmployee> {
  final _employemodel = EmployeeViewModel();

  final _formKey = GlobalKey<FormState>();

  bool favorite = false;
  String _selectedDate = "";
  String _selectedToDate = "";

  late TextEditingController _employeeName = TextEditingController();
  late TextEditingController _jonindate = TextEditingController();
  late TextEditingController _toDate = TextEditingController();
  late String employeeRole;

  String? selectedValue;

  List<DateTime?> _singleSelectedToday = [
    DateTime.now(),
  ];

  List<DateTime?> _singleSelectedTo = [
    DateTime.now(),
  ];

  @override
  void initState() {
    employeeRole = "";
  }

  @override
  Widget build(BuildContext context) {
    final employemodel = Provider.of<EmployeeViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(AppCaptions.employeeDetails),
        ),
        body: ChangeNotifierProvider<EmployeeViewModel>(
            create: (BuildContext context) => employemodel,
            child:
                Consumer<EmployeeViewModel>(builder: ((context, value, child) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: _employeeName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        cursorColor: Colors.black,
                        style: const TextStyle(color: Colors.blueAccent),
                        decoration: InputDecoration(
                          hintText: AppCaptions.employeename,
                          prefixIcon:
                              const Icon(Icons.person, color: Colors.blue),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: DropdownSearch<String>(
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                              label: Text(AppCaptions.role),
                              //  border: BorderRadius.circular(5),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.blueGrey, width: 1.0),
                              ),
                              hintText: AppCaptions.role,
                              //fillColor: Colors.amber,
                              prefixIcon: const Icon(
                                Icons.work,
                                color: Colors.blueAccent,
                              ),
                              suffixIcon: const Icon(Icons.arrow_drop_down)),
                        ),
                        items: const [
                          "Product Designer",
                          "Flutter Developer",
                          "QA Tester",
                          "Product Owner"
                        ],
                        selectedItem: employeeRole,
                        onChanged: (valueSelected) {
                          employeeRole = valueSelected ?? "";
                          debugPrint("After drodpdown =" + employeeRole);
                        },
                        popupProps: PopupProps.modalBottomSheet(
                          // isFilterOnline: true,
                          //  showSelectedItems: true,
                          //   showSearchBox: true,

                          constraints: const BoxConstraints(maxHeight: 250),
                          itemBuilder: _popupBuilder,
                          favoriteItemProps: FavoriteItemProps(
                            //  showFavoriteItems: true,
                            favoriteItems: (us) {
                              return us;
                            },
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              readOnly: true,
                              controller: _jonindate,
                              onTap: () async {
                                openDialogToDay();
                              },
                              cursorColor: Colors.blueAccent,
                              //  controller: _campDate,
                              keyboardType: TextInputType.datetime,
                              onChanged: (String text) {
                                //print("text $text");
                                FocusScope.of(context).nextFocus();
                              },
                              style: const TextStyle(color: Colors.blueAccent),
                              decoration: InputDecoration(
                                hintText: 'Today',
                                counterText: '',
                                prefixIcon: const Icon(Icons.date_range,
                                    color: Colors.blueAccent),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.blue, width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.blueGrey, width: 1.0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Icon(Icons.arrow_right_alt_sharp,
                            size: 50, color: Colors.blueAccent),
                        Flexible(
                            child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            readOnly: true,
                            controller: _toDate,
                            onTap: () async {
                              openDialogNext();
                            },
                            cursorColor: Colors.blueAccent,
                            //  controller: _campDate,
                            keyboardType: TextInputType.datetime,
                            onChanged: (String text) {
                              //print("text $text");
                              FocusScope.of(context).nextFocus();
                            },
                            style: const TextStyle(color: Colors.blue),
                            decoration: InputDecoration(
                              hintText: 'No Date',
                              counterText: '',
                              prefixIcon: const Icon(Icons.date_range,
                                  color: Colors.blueAccent),
                              labelStyle: const TextStyle(color: Colors.blue),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.blueGrey, width: 1.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ))
                      ],
                    ),
                    const Spacer(),
                    const Divider(
                      height: 20,
                      color: Colors.grey,
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SecondaryButton(
                            title: AppCaptions.cancelButton,
                            onpress: () {
                              Future.delayed(const Duration(milliseconds: 600),
                                  () {
                                Navigator.pushNamed(
                                    context, Routenames.homeScreen);
                              });
                            }),
                        const SizedBox(
                          width: 10,
                        ),
                        PrimaryButton(
                            title: AppCaptions.saveButton,
                            onpress: () {
                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                        'Employee  Data has been added!!'),
                                    action: SnackBarAction(
                                      label: 'Undo',
                                      onPressed: () {
                                        employemodel.deleteLatestEntry();
                                      },
                                    ),
                                  ),
                                );
                              }
                              if (_employeeName.text.isEmpty ||
                                  employeeRole.isEmpty ||
                                  _jonindate.text.isEmpty) {
                                showErrorToast("Fields can't be empty");
                              } else {
                                var employee = DataClassEmployee();
                                if (_toDate.text.isEmpty) {
                                  employee = DataClassEmployee(
                                      employeeName: _employeeName.text,
                                      employeeRole: employeeRole,
                                      employeeJoiningdate: _jonindate.text,
                                      employeeToDate: _toDate.text,
                                      employeeType: 1);
                                } else {
                                  employee = DataClassEmployee(
                                      employeeName: _employeeName.text,
                                      employeeRole: employeeRole,
                                      employeeJoiningdate: _jonindate.text,
                                      employeeToDate: _toDate.text,
                                      employeeType: 2);
                                }

                                employemodel.saveEmployee(employee);

                                Future.delayed(
                                    const Duration(milliseconds: 1200), () {
                                  Navigator.pushNamed(
                                      context, Routenames.homeScreen);
                                });

                                debugPrint(
                                    "Json Encode ${jsonEncode(employee)}");
                              }
                            }),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              );
            }))));
  }

  Widget _popupBuilder(BuildContext context, String item, bool isSelected) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.6, color: Colors.grey),
        ),
      ),
      child: ListTile(
        selected: isSelected,
        title: Text(item, textAlign: TextAlign.center),
      ),
    );
  }

  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();

    debugPrint("Dates ${values[0]}");
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    List<String> parseDate = valueText.split("-");

    String month = getMonthName(int.parse(parseDate[1]));

    _employemodel.setSelectedDate("${parseDate[2]} $month ${parseDate[0]}");

    _selectedDate = "${parseDate[2]} $month ${parseDate[0]}";

    return _employemodel.getselectedDate;
  }

  String _getValueTextNoDate(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    if (values.isEmpty) {
      return "No Date";
    } else {
      debugPrint("Dates ${values.length}");

      values =
          values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();

      debugPrint("Dates ${values[0]}");
      var valueText = (values.isNotEmpty ? values[0] : null)
          .toString()
          .replaceAll('00:00:00.000', '');

      List<String> parseDate = valueText.split("-");

      String month = getMonthName(int.parse(parseDate[1]));
      _employemodel.setSelectedDate("${parseDate[2]} $month ${parseDate[0]}");
      _selectedToDate = "${parseDate[2]} $month ${parseDate[0]}";
      return _selectedToDate;
    }
  }

  void openDialogToDay() {
    final config = CalendarDatePicker2Config(
      selectedDayHighlightColor: Colors.blue,
      weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      firstDayOfWeek: 1,
      controlsHeight: 50,
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      dayTextStyle: const TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold,
      ),
      disabledDayTextStyle: const TextStyle(
        color: Colors.grey,
      ),
      selectableDayPredicate: (day) => !day
          .difference(DateTime.now().subtract(const Duration(days: 3)))
          .isNegative,
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)), //this right here
              child: SizedBox(
                height: 550,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              child: SecondaryButton(
                                  title: AppCaptions.today,
                                  onpress: () {
                                    List<DateTime?> newDate = [DateTime.now()];

                                    //    debugPrint("Day of week ${}");

                                    setState(() {
                                      _singleSelectedToday = newDate;
                                    });
                                  })),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: SecondaryButton(
                                  title: AppCaptions.monday,
                                  onpress: () {
                                    var date = DateTime.now();
                                    debugPrint(
                                        "Day of the week: ${dayofWeek(DateTime.now())}");

                                    debugPrint(
                                        "Week day:: ${currentweekDay(DateTime(date.year, date.month, date.day - 3))}");
                                    debugPrint(
                                        "Week day After add:: ${currentweekDay(DateTime(date.year, date.month, date.day + 2 + 2))}");
                                    debugPrint(
                                        "Day of the week ${dayofWeek(DateTime(date.year, date.month, date.day + 4))}");

                                    List<DateTime?> newDate = [
                                      DateTime(
                                          date.year,
                                          date.month,
                                          date.day +
                                              returndaystobeAdded(
                                                  DateTime.now()))
                                    ];

                                    setState(() {
                                      _singleSelectedToday = newDate;
                                    });
                                  })),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              child: SecondaryButton(
                                  title: AppCaptions.tuesday,
                                  onpress: () {
                                    var date = DateTime.now();
                                    debugPrint(
                                        "Day of the week: ${dayofWeek(DateTime.now())}");

                                    debugPrint(
                                        "Week day:: ${currentweekDay(DateTime(date.year, date.month, date.day - 3))}");
                                    debugPrint(
                                        "Week day After add:: ${currentweekDay(DateTime(date.year, date.month, date.day + 2 + 2))}");
                                    debugPrint(
                                        "Day of the week ${dayofWeek(DateTime(date.year, date.month, date.day + 4))}");

                                    List<DateTime?> newDate = [
                                      DateTime(
                                          date.year,
                                          date.month,
                                          date.day +
                                              returndaystobeAdded(
                                                  DateTime.now()) +
                                              1)
                                    ];

                                    setState(() {
                                      _singleSelectedToday = newDate;
                                    });
                                  })),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: SecondaryButton(
                                  title: AppCaptions.week,
                                  onpress: () {
                                    var date = DateTime.now();
                                    List<DateTime?> newDate = [
                                      DateTime(
                                          date.year, date.month, date.day + 7)
                                    ];

                                    //    debugPrint("Day of week ${}");

                                    setState(() {
                                      _singleSelectedToday = newDate;
                                    });
                                  })),
                        ],
                      ),
                      CalendarDatePicker2(
                        config: config,
                        value: _singleSelectedToday,
                        onValueChanged: (dates) =>
                            setState(() => _singleSelectedToday = dates),
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        height: 10,
                        color: Colors.grey,
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 6,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const WidgetSpan(
                                      child: Icon(Icons.calendar_today,
                                          size: 20, color: Colors.blueAccent),
                                    ),
                                    TextSpan(
                                      text: "  ${_getValueText(
                                        config.calendarType,
                                        _singleSelectedToday,
                                      )}",
//text: _employemodel.selectedDate,
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Spacer(),
                              SecondaryButton(
                                  title: AppCaptions.cancelButton,
                                  onpress: () {
                                    Navigator.pop(context);
                                  }),
                              const SizedBox(
                                width: 10,
                              ),
                              PrimaryButton(
                                  title: AppCaptions.saveButton,
                                  onpress: () {
                                    _jonindate.text = _selectedDate;

                                    debugPrint("Date $_selectedDate");

                                    _employemodel
                                        .setSelectedDate(_selectedDate);

                                    _jonindate.text =
                                        _employemodel.getselectedDate;

                                    Navigator.pop(context);
                                  }),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  void openDialogNext() {
    final config = CalendarDatePicker2Config(
      selectedDayHighlightColor: Colors.blue,
      weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      firstDayOfWeek: 1,
      controlsHeight: 50,
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      dayTextStyle: const TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold,
      ),
      disabledDayTextStyle: const TextStyle(
        color: Colors.grey,
      ),
      selectableDayPredicate: (day) => !day
          .difference(DateTime.now().subtract(const Duration(days: 3)))
          .isNegative,
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)), //this right here
              child: SizedBox(
                height: 550,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              child: SecondaryButton(
                                  title: AppCaptions.nodate,
                                  onpress: () {
                                    List<DateTime?> newDate = [];

                                    setState(() {
                                      _singleSelectedTo = [];
                                      // _selectedToDate ="No Data";
                                    });
                                  })),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: SecondaryButton(
                                  title: AppCaptions.today,
                                  onpress: () {
                                    var date = DateTime.now();
                                    List<DateTime?> newDate = [
                                      DateTime(date.year, date.month, date.day)
                                    ];

                                    //    debugPrint("Day of week ${}");

                                    setState(() {
                                      _singleSelectedTo = newDate;
                                    });
                                  })),
                        ],
                      ),
                      CalendarDatePicker2(
                        config: config,
                        value: _singleSelectedTo,
                        onValueChanged: (dates) =>
                            setState(() => _singleSelectedTo = dates),
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        height: 10,
                        color: Colors.grey,
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const WidgetSpan(
                                      child: Icon(Icons.calendar_today,
                                          size: 20, color: Colors.blueAccent),
                                    ),
                                    TextSpan(
                                      text: "  ${_getValueTextNoDate(
                                        config.calendarType,
                                        _singleSelectedTo,
                                      )}",
//text: _employemodel.selectedDate,
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Spacer(),
                              SecondaryButton(
                                  title: AppCaptions.cancelButton,
                                  onpress: () {
                                    Navigator.pop(context);
                                  }),
                              const SizedBox(
                                width: 10,
                              ),
                              PrimaryButton(
                                  title: AppCaptions.saveButton,
                                  onpress: () {
                                    _toDate.text = _selectedToDate;

                                    Navigator.pop(context);
                                  }),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }
}
