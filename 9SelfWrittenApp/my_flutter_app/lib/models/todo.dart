import 'package:flutter/material.dart';

class Todo {

  String name;
  String creatorUid;
  String description;
  bool isDone;

  Todo({@required name,@required creatorUid, description, isDone }) {
    this.name = name;
    this.creatorUid = creatorUid;
    this.isDone = isDone ?? false;
    this.description = description ?? null;
  }

}