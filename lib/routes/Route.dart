import 'package:flutter/material.dart';

import '../views/AddEmployee.dart';
import '../views/Dashboard.dart';
import '../views/SplashScreen.dart';
import 'Routenames.dart';

class Routes {
  static Route<dynamic> generatedRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routenames.splashScreen:
        return MaterialPageRoute(
            builder: (BuildContext buildcontext) => SpashScreen());
      case Routenames.addEmployee:
        return MaterialPageRoute(
            builder: (BuildContext buildcontext) => AddEmployee());

      case Routenames.homeScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => Dashboard());

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            appBar: AppBar(
              title: Text('No Routes'),
            ),
            body: const Center(
              child: Text('No Routes'),
            ),
          );
        });
    }
  }
}
