import 'package:flutter/material.dart';
//import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:my_flutter_app/utils/auth.dart';

// Widget to show a Welcome page, in foreground of the user page
// I need a Stateful Widget, and not a Stateless Widget,
// because I need the widget to rebuild when this.show is put to false
// e.g. when the user pressed "Start" button
// After the first time the user pressed start button,
// this widget will just return widget.child;
class WelcomeSplashScreen extends StatefulWidget {
  final double opacity;
  final Color color;
  final Widget child;
  bool show;

  WelcomeSplashScreen({
    Key key,
    this.opacity = 0.7,
    this.color = Colors.white,
    this.show = true,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  _WelcomeSplashScreenState createState() => _WelcomeSplashScreenState();
}

class _WelcomeSplashScreenState extends State<WelcomeSplashScreen> {
  final AuthService _auth = AuthService();

  void hideWelcomeWidget() {
    setState(() {
      this.widget.show = false;
    });
  }

  /*
  Future<bool> isUserAlreadyOpennedTheApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _userAlreadyOpennedTheApp =
        (prefs.getBool('userAlreadyOpennedTheApp') ?? false);
    if (_userAlreadyOpennedTheApp) {
      return (true);
    } else {
      prefs.setBool('seen', true);
      return (false);
    }

    return (_userAlreadyOpennedTheApp);
  }
  */

  @override
  Widget build(BuildContext context) {
    if (this.widget.show) {

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
                  child: Text("Hello World", style: TextStyle(fontSize: 26)),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    padding: const EdgeInsets.all(8.0),
                    onPressed: () => {hideWelcomeWidget()},
                    child: const Text('Start', style: TextStyle(fontSize: 26)),
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                )
              ],
            ),
          ));
      final modal = [
        new Opacity(
          child: new ModalBarrier(color: widget.color),
          opacity: this.widget.opacity,
        ),
        welcomeUser
      ];
      widgetList += modal;
      return new Stack(
        children: widgetList,
      );
    }
    return widget.child;
  }
}
