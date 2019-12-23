import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:my_flutter_app/models/user.dart';
import 'package:my_flutter_app/utils/auth.dart';

class UserScreen extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Center(
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
    );
  }
}
