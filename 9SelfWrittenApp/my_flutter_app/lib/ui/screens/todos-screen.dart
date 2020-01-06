import 'package:flutter/material.dart';
import 'package:my_flutter_app/models/user.dart';
import 'package:provider/provider.dart';

import 'package:my_flutter_app/models/todo.dart';
import 'package:my_flutter_app/utils/database.dart';

class TodosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamProvider<List<Todo>>.value(
      value: DatabaseService().todosFromDefaultTodoList(user.uid),
      child: TodoList(),
    );
  }
}

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todos = Provider.of<List<Todo>>(context) ?? [];
    todos.insert(0, null); // to add a title
    // it is not possible to add ListTile here because todos is composed of Todo

    if (todos.length == 1) { /// 0 + 1 for title
      return Center(
          child: Text("No todo yet",
              style: TextStyle(
                fontSize: 16.0,
              )));
    } else {
      return ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            // to add a title
            return ListTile(
              title: Center(
                child: Text(
                  "Your default todo list",
                  //style: Theme.of(context).textTheme.headline,
                ),
              ),
            );
          } else {
            return TodoTile(todo: todos[index]);
          }
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
    return Card(
      margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
      child: ListTile(
        title: Text(todo.name),
        subtitle: todo.description != null
            ? (todo.description.length > 40)
                ? Text(todo.description.substring(0, 40) + "...")
                : Text(todo.description)
            : null,
      ),
    );
  }
}
