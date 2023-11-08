import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

String getMonthName(int mon) {
  switch (mon) {
    case 01:
      {
        return "Jan";
      }
    case 02:
      {
        return "Feb";
      }

    case 03:
      {
        return "Mar";
      }

    case 04:
      {
        return "Apr";
      }
    case 05:
      {
        return "May";
      }
    case 06:
      {
        return "Jun";
      }
    case 07:
      {
        return "Jul";
      }
    case 08:
      {
        return "Aug";
      }
    case 09:
      {
        return "Sep";
      }
    case 10:
      {
        return "Oct";
      }
    case 11:
      {
        return "Nov";
      }

    case 12:
      {
        return "Dec";
      }
    default:
      {
        return "";
      }
  }
}

DateTime findFirstDateOfTheWeek(DateTime dateTime) {
  return dateTime.subtract(Duration(days: dateTime.weekday - 1));
}

int dayofWeek(DateTime dateTime) {
  //debugPrint("Current of the week ${dateTime.weekday}");
  return dateTime.weekday;
}

int currentweekDay(DateTime dateTime) {
  // debugPrint("Current of the week ${dateTime.weekday}");
  return dateTime.weekday;
}

int returndaystobeAdded(DateTime datetinme) {
  switch (datetinme.weekday) {
    case 1:
      {
        return 7;
      }

    case 2:
      {
        return 6;
      }

    case 3:
      {
        return 5;
      }

    case 4:
      {
        return 4;
      }

    case 5:
      {
        return 3;
      }

    case 6:
      {
        return 2;
      }

    case 7:
      {
        return 1;
      }

    default:
      {
        return 0;
      }
  }
}

showErrorToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

showSuccessToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.greenAccent,
      textColor: Colors.white,
      fontSize: 16.0);
}
