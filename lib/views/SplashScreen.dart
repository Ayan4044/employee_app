import 'dart:async';

import 'package:flutter/material.dart';

import '../routes/Routenames.dart';
import '../utils/StatefulWrapper.dart';

class SpashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () {
        Future.delayed(const Duration(milliseconds: 1200), () {
          Navigator.pushNamed(context, Routenames.homeScreen);
        });
      },
      child: Container(
          color: Colors.white,
          child: FlutterLogo(size: MediaQuery.of(context).size.height)),
    );
  }
}
