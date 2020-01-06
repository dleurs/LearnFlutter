import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String questionText;
  final Function toExecuteOnPressed; 
  Answer({this.questionText, this.toExecuteOnPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      //width: double.infinity,
      child: RaisedButton(
        child: Text(questionText),
        color: Colors.blue[200],
        onPressed: toExecuteOnPressed,
      ),
    );
  }
}
