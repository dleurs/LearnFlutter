import 'package:flutter/material.dart';

class CenteredText extends StatelessWidget {
  final String text;

  CenteredText(this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Text(
        text,
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }
}