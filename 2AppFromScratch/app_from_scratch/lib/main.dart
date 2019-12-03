import 'package:flutter/material.dart';

import './quiz.dart';
import './result.dart';

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
        {"text": "Tennis", "score": 5},
        {"text": "Taekwondo", "score": 10}
      ]
    },
    {
      "quesionText": "What is your favorite animal ?",
      "answers": [
        {"text": "Horse", "score": 10},
        {"text": "Cat", "score": 5},
        {"text": "Dog", "score": 0}
      ]
    },
    {
      "quesionText": "What is your favorite programming language ?",
      "answers": [
        {"text": "Python", "score": 10},
        {"text": "Java", "score": 0},
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
      _scoreUser = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('My First App')),
            body: _indexQuestion < questionsAndAnswers.length
                ? Quiz(
                    questionsAndAnswers: questionsAndAnswers,
                    indexQuestion: _indexQuestion,
                    clickButtonQuestion: _clickButtonQuestion,
                  )
                : Result(
                    resetButton: _resetButton,
                    scoreUser: _scoreUser,
                  )));
  }
}
