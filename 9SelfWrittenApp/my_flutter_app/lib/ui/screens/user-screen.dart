import 'package:flutter/material.dart';
import 'package:my_flutter_app/ui/register.dart';
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
    final user = Provider.of<User>(context);

    List<Widget> buildMenu() {
      List<Widget> builder = [];

      if (user.isAnonymous) {
        builder.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Anonymous user",
              style: TextStyle(
                fontSize: 24.0,
              )),
        ));
        builder.add(Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 20.0),
          child: Text("Register now :"),
        ));
      }
      else {
        builder.add(Text(user.pseudo));
      }

      if (!register0SignIn1) {
        builder.add(Register());
      }

      builder.add(RaisedButton(
        onPressed: () => _switchRegisterSignIn(),
        child: register0SignIn1
            ? Text('Don\'t have an account ? Register')
            : Text('Have an Account ? Sign In'),
      ));

      if (user != null && !user.isAnonymous) {
        builder.add(RaisedButton(
          onPressed: () async {
            await _auth.signOut();
          },
          child: Text('Logout'),
        ));
      }

      builder.add(Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(user.toString()),
      ));

      return builder;
    }

    return Center(
      child: Column(
        children: buildMenu(),
      ),
    );
  }
}
