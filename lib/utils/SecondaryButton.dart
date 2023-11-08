import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String title;
  final VoidCallback onpress;

  const SecondaryButton({Key? key, required this.title, required this.onpress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0.0,
          shadowColor: Colors.transparent,
          primary: Color(0XFFEDF8FF),
          onPrimary: Colors.blueAccent),
      onPressed: onpress,
      child: Text("$title"),
    );
  }
}
