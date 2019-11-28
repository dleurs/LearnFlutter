import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _indexQuestion = 0;

  void _clickButtonQuestion(int inputIndexQuestion) {
    setState(() {
      _indexQuestion = inputIndexQuestion;
    });
  }

  @override
  Widget build(BuildContext context) {
    var questions = [
      "What is your favorite sport ?",
      "What is your favorite game ?",
      "What is your favourite programming language ?"
    ];
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: Text('My First App')),
          body: Column(children: [
            Text(questions[_indexQuestion]),
            RaisedButton(
              child: Text('Question 1'),
              onPressed: () => _clickButtonQuestion(0),
            ),
            RaisedButton(
              child: Text('Question 2'),
              onPressed: () => _clickButtonQuestion(1),
            ),
            RaisedButton(
              child: Text('Question 3'),
              onPressed: () => _clickButtonQuestion(2),
            ),
          ])),
    );
  }
}
