import 'package:flutter_auth_app/screens/authenticate/authenticate.dart';
import 'package:flutter_auth_app/screens/home/home.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    // return either the Home or Authenticate widget
    return Authenticate();
    
  }
}