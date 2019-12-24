import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:my_flutter_app/models/user.dart';
import 'package:my_flutter_app/utils/auth.dart';
import 'package:my_flutter_app/ui/screens/user-screen.dart';
import 'package:my_flutter_app/ui/screens/todo-screen.dart';
import 'package:my_flutter_app/ui/screens/calendar-screen.dart';
import 'package:my_flutter_app/ui/screens/group-screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'My Flutter App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: BaseScaffold(),
      ),
    );
  }
}

class BaseScaffold extends StatefulWidget {
  @override
  _BaseScaffoldState createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    TodoScreen(),
    CalendarScreen(),
    GroupScreen(),
    UserScreen(),
  ];

  final List<String> _childrenTitle = [
    "Todo",
    "Calendar",
    "Groups",
    "User",
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _createTodo() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: Text("Hello - Add todo here"),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_childrenTitle[_currentIndex]),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.white,
            iconSize: 38.0,
            onPressed: () => _createTodo(),
          ),
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey[700],
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            // Index 0 : Todo list
            icon: Icon(Icons.format_list_bulleted),
            title: Text('Todo'),
          ),
          BottomNavigationBarItem(
            // Index 1 : Todo Calendar
            icon: Icon(Icons.calendar_today),
            title: Text('Calendar'),
          ),
          BottomNavigationBarItem(
            // Index 2 : Groups
            icon: Icon(Icons.group),
            title: Text('Groups'),
          ),
          BottomNavigationBarItem(
            // Index 3 : User
            icon: Icon(Icons.assignment_ind),
            title: Text('User'),
          ),
        ],
      ),
    );
  }
}
