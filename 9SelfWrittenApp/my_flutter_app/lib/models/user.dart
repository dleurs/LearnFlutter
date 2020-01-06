import 'package:flutter/foundation.dart';

class User {
  final String uid;
  bool _isAnonymous;
  String _username;
  String _email;

  User({@required this.uid, String username, String email}) {
    this._isAnonymous = false;
    this._username = username;
    this._email = email;
  }

  User.anonymous({@required this.uid}) {
    this._isAnonymous = true;
    this._username = null;
    this._email = null;
  }

  bool get isAnon => _isAnonymous;

  String toString() => "uid: ${this.uid}";
}
