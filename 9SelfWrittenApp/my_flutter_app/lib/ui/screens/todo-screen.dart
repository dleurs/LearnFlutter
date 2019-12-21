import 'package:flutter/material.dart';
import 'package:my_flutter_app/ui/widgets/base-scaffold.dart';
import 'package:provider/provider.dart';

import 'package:my_flutter_app/models/user.dart';
import 'package:my_flutter_app/utils/auth.dart';
import 'package:my_flutter_app/ui/screens/welcome-splash-screen.dart';

class TodoScreen extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return BaseScaffold( // lib/ui/widgets/base-scaffold.dart
        title: "Todo List",
        body: WelcomeSplashScreen(
          // Only show up something different than child
          // if the user open the app for first time
          child: Center(
            child: Column(
              children: <Widget>[
                Text("Todo List Here"),
                Text(user.toString()),
              ],
            ),
          ),
        ));
  }
}
