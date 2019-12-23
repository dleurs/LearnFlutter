import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:my_flutter_app/models/user.dart';
import 'package:my_flutter_app/utils/auth.dart';
import 'package:my_flutter_app/ui/screens/user-screen.dart';
import 'package:my_flutter_app/ui/screens/todo-screen.dart';

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
        //debugShowCheckedModeBanner: false,
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
    TodoScreen(),
    TodoScreen(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_childrenTitle[_currentIndex]),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey[700],
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem( // Index 0 : Todo list
            icon: Icon(Icons.format_list_bulleted),
            title: Text('Todo'),
          ),
          BottomNavigationBarItem( // Index 1 : Todo Calendar
            icon: Icon(Icons.calendar_today),
            title: Text('Calendar'),
          ),
          BottomNavigationBarItem( // Index 2 : Groups
            icon: Icon(Icons.group),
            title: Text('Groups'),
          ),
          BottomNavigationBarItem( // Index 3 : User
            icon: Icon(Icons.assignment_ind),
            title: Text('User'),
          ),
        ],
      ),
    );
  }
}


/* If you want a Navigator Menu, use this code inside AppBar()
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                onDetailsPressed: () {
                  Navigator.pushNamed(context, '/user/');
                },
                accountName: Text("Ashish Rawat"),
                accountEmail: Text("ashishrawat2911@gmail.com"),
                currentAccountPicture: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/user/');
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.blue[50],
                    child: Text(
                      "A",
                      style: TextStyle(fontSize: 40.0),
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text("Todo List"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.pushNamed(context, '/todo/');
                },
              ),
              ListTile(
                title: Text("User"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.pushNamed(context, '/user/');
                },
              ),
            ],
          ),
        ),
        */
