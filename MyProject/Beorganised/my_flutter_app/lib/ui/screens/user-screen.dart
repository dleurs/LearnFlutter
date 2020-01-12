import 'package:flutter/material.dart';
import 'package:my_flutter_app/models/loading.dart';
import 'package:my_flutter_app/ui/register.dart';
import 'package:my_flutter_app/ui/sign_in.dart';
import 'package:my_flutter_app/utils/loading-ui.dart';
import 'package:provider/provider.dart';

import 'package:my_flutter_app/models/user.dart';
import 'package:my_flutter_app/utils/auth.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final AuthService _auth = AuthService();
  bool register0SignIn1 = false;

  void _switchRegisterSignIn() {
    setState(() {
      register0SignIn1 = !register0SignIn1;
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    var loading = Provider.of<Loading>(context);

    List<Widget> buildMenu() {
      List<Widget> builder = [];

      if (user != null) {
        builder.add(Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 0.0),
          child: Text("Hello"),
        ));
        if (user.databaseUserInfoLoaded) {
          if (user.isAnonymous) {
            builder.add(Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
              child: Text("Anonymous user",
                  style: TextStyle(
                    fontSize: 24.0,
                  )),
            ));
          } else {
            // user is logging with email and pseudo
            builder.add(Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
              child: Text(user.pseudo,
                  style: TextStyle(
                    fontSize: 24.0,
                  )),
            ));
          }
        }
        builder.add(RaisedButton(
          onPressed: () async {
            await _auth.signOut();
          },
          child: Text('Logout'),
        ));
      } else {
        builder.add(Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 18.0, 8.0, 8.0),
          child: Text("You are not connected",
              style: TextStyle(
                fontSize: 20.0,
              )),
        ));
      }

      if (user == null || (user.databaseUserInfoLoaded && user.isAnonymous)) {
        if (!register0SignIn1) {
          // if in Register mode5
          builder.add(Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 8.0),
            child: Text("Register now :"),
          ));
          builder.add(Register());
        } else {
          // if in Sign in mode
          builder.add(Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 8.0),
            child: Text("Sign in now :"),
          ));
          builder.add(SignIn());
        }
      }

      if (user == null || user.isAnonymous) {
        builder.add(FlatButton(
          onPressed: () => _switchRegisterSignIn(),
          child: register0SignIn1
              ? Text(
                  'Don\'t have an account ? Register',
                  style: TextStyle(color: Colors.black54),
                )
              : Text(
                  'Have an Account ? Sign In',
                  style: TextStyle(color: Colors.black54),
                ),
        ));
      }

      builder.add(Text(
        user.toString(),
        style: TextStyle(color: Colors.black.withOpacity(0.2)),
      ));

      return builder;
    }

    return LoadingScreen(
        child: Center(
          child: Column(
            children: buildMenu(),
          ),
        ),
        inAsyncCall: loading.isLoading);
  }
}
