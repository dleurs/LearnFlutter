import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:my_flutter_app/models/user.dart';
import 'package:my_flutter_app/utils/auth.dart';
import 'package:my_flutter_app/ui/screens/welcomeSplashScreen.dart';

class UserScreen extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    bool _loadingVisible = false;

    return Scaffold(
        appBar: AppBar(
          title: Text('First Screen'),
        ),
        body: WelcomeSplashScreen(
          // Only show up if the user open the app for first time
          child: Center(
            child: Column(
              children: <Widget>[
                Text(user.toString()),
                RaisedButton(
                  onPressed: () async {
                    await _auth.signOut();
                  },
                  child: Text('Logout'),
                )
              ],
            ),
          ),
        ));
  }
}
