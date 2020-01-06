import 'package:flutter/material.dart';
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

    return Center(
      child: Column(
        children: <Widget>[
          Text(user.toString()),
          RaisedButton(
            onPressed: () => _switchRegisterSignIn(),
            child: register0SignIn1
                ? Text('Don\'t have an account ? Register')
                : Text('Have an Account? Sign In'),
          ),
          RaisedButton(
            onPressed: () async {
              await _auth.signOut();
            },
            child: Text('Logout'),
          )
        ],
      ),
    );
  }
}
