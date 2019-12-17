import 'package:flutter_auth_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_app/shared/centeredText.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('My App'),
          backgroundColor: Colors.blue,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            CenteredText("Hello user !"),
          ],
        )
      ),
    );
  }
}