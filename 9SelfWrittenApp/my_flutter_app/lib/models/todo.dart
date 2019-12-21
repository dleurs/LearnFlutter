import 'package:flutter/material.dart';

class Todo {

  String _name;
  String _creatorUid;
  bool _isDone;

  Todo({@required name,@required creatorUid, isDone }) {
    this._name = name;
    this._creatorUid = creatorUid;
    this._isDone = isDone ?? false;
  }

}