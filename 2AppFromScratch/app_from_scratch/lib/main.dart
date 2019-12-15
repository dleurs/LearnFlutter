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
  int _scoreUser = 0;

  final questionsAndAnswers = [
    {
      "quesionText": "What is your favorite sport ?",
      "answers": [
        {"text": "Football", "score": 0},
        {"text": "Tennis", "score": 4},
        {"text": "Taekwondo", "score": 10},
        {"text": "Just Dance", "score": 5},
      ]
    },
    {
      "quesionText": "What is your favorite animal ?",
      "answers": [
        {"text": "Horse", "score": 10},
        {"text": "Frog", "score": 0},
        {"text": "Cat", "score": 5},
        {"text": "Dog", "score": 0}
      ]
    },
    {
      "quesionText": "What is your favorite programming language ?",
      "answers": [
        {"text": "Python", "score": 10},
        {"text": "Java", "score": 4},
        {"text": "C", "score": 0},
        {"text": "Dart", "score": 5}
      ]
    },
  ];

  void _clickButtonQuestion(int score) {
    if (_indexQuestion < questionsAndAnswers.length) {
      setState(() {
        _indexQuestion += 1;
        _scoreUser += score;
      });
    }
  }

  void _resetButton() {
    setState(() {
      _indexQuestion = 0;
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
