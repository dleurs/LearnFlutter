import 'package:flutter/material.dart';

import './answer.dart';
import './question.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questionsAndAnswers;
  final int indexQuestion;
  final Function clickButtonQuestion;

  Quiz(
      {@required this.questionsAndAnswers,
      @required this.indexQuestion,
      @required this.clickButtonQuestion});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Question(questionsAndAnswers[indexQuestion]['quesionText']),
      ...(questionsAndAnswers[indexQuestion]["answers"] as List<Map<String, Object>>)
          .map((answer) {
        //Answer(questionText: answer, toExecuteOnPressed: _clickButtonQuestion),
        return Answer(
            questionText: answer["text"], toExecuteOnPressed: () => clickButtonQuestion(answer["score"]));
      }).toList()
    ]);
  }
}
