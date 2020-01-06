import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:my_flutter_app/ui/screens/calendar-screen.dart';
import 'package:my_flutter_app/models/user.dart';
import 'package:my_flutter_app/utils/auth.dart';
import 'package:my_flutter_app/ui/screens/user-screen.dart';
import 'package:my_flutter_app/ui/screens/todos-screen.dart';
import 'package:my_flutter_app/ui/screens/groups-screen.dart';
import 'package:my_flutter_app/ui/screens/todo-lists-screen.dart';
import 'package:my_flutter_app/utils/loading.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //final AuthService _auth = AuthService();

  Future<bool> _userAlreadyOpenApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _userAlreadyOpenApp = (prefs.getBool('userAlreadyOpenApp') ?? false);
    if (!_userAlreadyOpenApp) {
      prefs.setBool('userAlreadyOpenApp', true);
    }
    return (_userAlreadyOpenApp);
  }

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
        home: FutureBuilder<bool>(
            future: _userAlreadyOpenApp(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Error - return function userAlreadyOpenApp");
              } else if (!snapshot.hasData) {
                return Loading();
              } else if (snapshot.hasData && snapshot.data == false) {
                AuthService().signInAnonymous();
                return BaseScaffold();
              } else {
                return BaseScaffold();
              }
            }),
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
    TodosScreen(),
    CalendarScreen(),
    TodoListsScreen(),
    GroupsScreen(),
    UserScreen(),
  ];

  final List<String> _childrenTitle = [
    "Todos",
    "Calendar",
    "Todo groups",
    "Friends",
    "User",
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void createTodo() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          final user = Provider.of<User>(context);
          if (user == null) {
            return Text("You should be connected");
          } else {
            return Form(
              child: Column(
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                    child: Text("Hello - Add todo here"),
                  ),
                  Text(user.toString()),
                ],
              ),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_childrenTitle[_currentIndex]),
        leading: IconButton(
          icon: Icon(Icons.search),
          iconSize: 32.0,
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.white,
            iconSize: 38.0,
            onPressed: () => createTodo(),
          ),
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey[700],
        //showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            // Index 0 : Todo
            icon: Icon(Icons.format_list_bulleted),
            title: Text('Todos'),
          ),
          BottomNavigationBarItem(
            // Index 1 : Todo Calendar
            icon: Icon(Icons.calendar_today),
            title: Text('Calendar'),
          ),
          BottomNavigationBarItem(
            // Index 2 : Todo Group
            icon: Icon(Icons.view_agenda),
            title: Text('Todo Lists'),
          ),
          BottomNavigationBarItem(
            // Index 3 : Friends
            icon: Icon(Icons.group),
            title: Text('Groups'),
          ),
          BottomNavigationBarItem(
            // Index 4 : User
            icon: Icon(Icons.assignment_ind),
            title: Text('User'),
          ),
        ],
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () => createTodo(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),*/
    );
  }
}
