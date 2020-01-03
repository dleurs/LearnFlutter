import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:my_flutter_app/models/todo.dart';
import 'package:my_flutter_app/utils/database.dart';

class TodoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Todo>>.value(
      value: DatabaseService().todos,
      child: TodoList(),
    );
  }
}

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todoList = Provider.of<List<Todo>>(context) ?? [];
    if (todoList.length == 0) {
      return Center(
          child: Text("No todo yet",
              style: TextStyle(
                fontSize: 16.0,
              )));
    } else {
      return ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return TodoTile(todo: todoList[index]);
        },
      );
    }
  }
}

class TodoTile extends StatelessWidget {
  final Todo todo;
  TodoTile({this.todo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          title: Text(todo.name),
          subtitle: Text(todo.description),
        ),
      ),
    );
  }
}
