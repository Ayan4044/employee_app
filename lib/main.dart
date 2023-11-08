import 'package:employee_app/resource/AppCaptions.dart';
import 'package:employee_app/routes/Route.dart';
import 'package:employee_app/routes/Routenames.dart';
import 'package:employee_app/viewmodel/EmployeeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_create) => EmployeeViewModel()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppCaptions.appName,
          navigatorKey: navigatorKey,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: Routenames.splashScreen,
          onGenerateRoute: Routes.generatedRoutes,
        ));
  }
}
