import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class User {
  final String uid;
  String _pseudo;
  String _email;

  User({@required this.uid, String pseudo, String email}) {
    this._pseudo = pseudo;
    this._email = email;
  }

  User.anonymous({@required this.uid}) {
    this._pseudo = null;
    this._email = null;
  }

  factory User.fromDocument({DocumentSnapshot docUser}) => new User(
        uid: docUser.data["uid"],
        pseudo: docUser.data["pseudo"],
        email: docUser.data["email"],
      );

  bool get isAnonymous => (_pseudo == null && _email == null);
  String get pseudo => _pseudo;

  String toString() {
    String res = "";
    res += "uid: ${this.uid}";
    if (this.isAnonymous) {
      res += ", anonymous user";
    } else {
      res += ", pseudo: ${this._pseudo}, email: ${this._email}";
    }
    return res;
  }
}
