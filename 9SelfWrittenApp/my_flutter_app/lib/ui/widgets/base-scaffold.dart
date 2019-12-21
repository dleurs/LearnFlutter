import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  final String title;
  final Widget body;

  BaseScaffold({this.title, this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
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
        body: body);
  }
}
