import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback onpress;

  const PrimaryButton({Key? key, required this.title, required this.onpress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        shadowColor: Colors.transparent,
        primary: Colors.blue,
      ),
      onPressed: onpress,
      child: Text("$title"),
    );
  }
}
