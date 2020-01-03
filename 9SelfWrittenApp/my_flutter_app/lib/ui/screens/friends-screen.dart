import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:my_flutter_app/models/user.dart';

class FriendsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Center(
      child: Column(
        children: <Widget>[
          Text("Group"),
        ],
      ),
    );
  }
}
