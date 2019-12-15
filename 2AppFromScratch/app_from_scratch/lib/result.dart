import 'package:flutter/material.dart';

class Result extends StatelessWidget {

  final Function resetButton;
  final int scoreUser;

  Result({this.resetButton, this.scoreUser});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          child: Text("Well done ! You answered all questions !",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
              )),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Text("You're score is " + scoreUser.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              )),
        ),
        Container(
          //width: double.infinity,
          child: RaisedButton(
            child: Text("Reset"),
            color: Colors.orange[200],
            onPressed: resetButton,
          ),
        )
      ],
    );
  }
}
