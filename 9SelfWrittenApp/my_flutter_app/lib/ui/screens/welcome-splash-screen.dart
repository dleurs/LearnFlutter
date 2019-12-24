//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:my_flutter_app/utils/auth.dart';

// Widget to show a Welcome page, in foreground of the user page
// I need a Stateful Widget, and not a Stateless Widget,
// because I need the widget to rebuild when the user pressed "Start" button 
// It happen only the first time the user open the app.
// After the first time the user pressed start button,
// this widget will just return widget.child;
class WelcomeSplashScreen extends StatefulWidget {
  final Widget child;

  WelcomeSplashScreen({@required this.child});

  @override
  _WelcomeSplashScreenState createState() => _WelcomeSplashScreenState();
}

class _WelcomeSplashScreenState extends State<WelcomeSplashScreen> {
  final AuthService _auth = AuthService();

  void reloadWidget() {
    _auth.signInAnon();
    setState(() {}); // just reload the widget, as prefs.getBool('userAlreadyOpenApp') is now true
  }

  Future<bool> _userAlreadyOpenApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _userAlreadyOpenApp = (prefs.getBool('userAlreadyOpenApp') ?? false);
    //print(_userAlreadyOpenApp);
    if (!_userAlreadyOpenApp) {
      prefs.setBool('userAlreadyOpenApp', true);
      return (false);
    }
    return (true);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: _userAlreadyOpenApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error");
          } else if (!snapshot.hasData) {
            return Text("Wait");
          } else if (snapshot.hasData && snapshot.data == false) {
            //print("Snapshot data");
            //print(snapshot.data);
            List<Widget> widgetList = [];
            widgetList.add(widget.child);
            Widget welcomeUser;
            welcomeUser = Align(
                alignment: Alignment(0, -0.75),
                child: Container(
                  height: 300,
                  width: 300,
                  margin: const EdgeInsets.all(30.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    border: Border.all(
                      width: 5,
                      color: Colors.blue[200],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topCenter,
                        child:
                            Text("Hello World", style: TextStyle(fontSize: 26)),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: RaisedButton(
                          padding: const EdgeInsets.all(8.0),
                          onPressed: () => {reloadWidget()},
                          child: const Text('Start',
                              style: TextStyle(fontSize: 26)),
                          color: Colors.blue,
                          textColor: Colors.white,
                        ),
                      )
                    ],
                  ),
                ));
            final modal = [
              new Opacity(
                child: new ModalBarrier(color: Colors.white),
                opacity: 0.7,
              ),
              welcomeUser
            ];
            widgetList += modal;
            return new Stack(
              children: widgetList,
            );
          } else {
            return widget.child;
          }
        });
  }
}
