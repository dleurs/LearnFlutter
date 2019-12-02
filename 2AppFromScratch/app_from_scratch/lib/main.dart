import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';

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
      "What is your favourite programming language ?",
    ];
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: Text('My First App')),
          body: Column(children: [
            Question(questions[_indexQuestion]),
            Answer(questionText:"Question 1", toExecuteOnPressed:()=>_clickButtonQuestion(0)),
            Answer(questionText:"Question 2", toExecuteOnPressed:()=>_clickButtonQuestion(1)),
            Answer(questionText:"Question 3", toExecuteOnPressed:()=>_clickButtonQuestion(2)),
          ])),
    );
  }
}
