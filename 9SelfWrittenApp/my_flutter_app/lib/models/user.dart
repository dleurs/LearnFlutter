import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:my_flutter_app/utils/database.dart';

class User {
  final String uid;
  String _pseudo;
  String _email;

  User({@required this.uid});

  bool get isAnonymous => (_pseudo == null && _email == null);

  String get pseudo => _pseudo;
  String get email => _email;

  set pseudo(String pseudo) {
    this.pseudo = pseudo;
  }

  set email(String email) {
    this.email = email;
  }

  Future updateUser() async {
    Map<String, dynamic> dataUserFirestore = await DatabaseService(uid:uid).getUserFirestore();
    print(dataUserFirestore);
    this._pseudo = dataUserFirestore["pseudo"] ?? null;
    this._email =  dataUserFirestore["email"] ?? null;
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
