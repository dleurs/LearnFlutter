import 'package:flutter/material.dart';

import 'package:my_flutter_app/ui/screens/welcome-splash-screen.dart';

class TodoScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return WelcomeSplashScreen(
          // Only show up something different than child
          // if the user open the app for first time
          // I didn't create a new widget,
          // to get TodoScreen in background, using ModalBarrier
          child: Center(
            child: Column(
              children: <Widget>[
                Text("Todo List Here"),
              ],
            ),
          ),
    );
  }
}
