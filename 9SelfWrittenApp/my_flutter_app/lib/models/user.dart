import 'package:flutter/foundation.dart';

class User {
  final String uid;
  String _pseudo;
  String _email;

  User({@required this.uid});

  bool get isAnonymous => (_pseudo == null && _email == null);

  set pseudo(String pseudo) {
    this.pseudo = pseudo;
  } 

  set email(String email) {
    this.email = email;
  } 

  String toString() {
    String res = "uid: ${this.uid}";
    if (this.isAnonymous) {
      res += ", anonymous user";
    } else {
      res += ", pseudo: ${this._pseudo}, email: ${this._email}";
    }
    return res;
  }
}
