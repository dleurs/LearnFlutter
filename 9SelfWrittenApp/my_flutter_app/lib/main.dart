import 'package:flutter/material.dart';
import 'package:my_flutter_app/ui/widgets/welcomeUser.dart';
import 'package:provider/provider.dart';

import 'package:my_flutter_app/models/user.dart';
import 'package:my_flutter_app/utils/auth.dart';

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
        initialRoute: '/',
        routes: {
          '/': (context) => FirstScreen(),
        },
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    /*
    if (user == null) { // First time open the app
      final AuthService _auth = AuthService();
      dynamic result = _auth.signInAnon();
      print(result);
    }
    */
    return Scaffold(
        appBar: AppBar(
          title: Text('First Screen'),
        ),
        body: WelcomeUser( // Only show up if the user open the app for first time
          child: Center(
            child: Column(
              children: <Widget>[
                Text(user.toString()),
                /*
              RaisedButton(
              onPressed: () async {
                await _auth.signOut();
              },
              child: Text(
              'Logout'
              ),
            )
            */
              ],
            ),
          ),
        ));
  }
}
