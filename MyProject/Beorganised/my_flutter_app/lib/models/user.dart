//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class User {
  final String uid;
  final bool isAnonymous;
  final String pseudo;
  final String email;

  User({@required this.uid, @required this.isAnonymous, this.pseudo, this.email});

  factory User.fromMap(Map data) {
    return User(
      uid: data['uid'],
      isAnonymous: data['isAnonymous'],
      pseudo: data['pseudo'] ?? 'No pseudo',
      email: data['email'] ?? 'No email',
    );
  }

  //bool get isAnonymous => isAnonymous; // no need because isAnonymous is not private


  String toString() {
    String res = "uid: ${this.uid},";
    if (this.isAnonymous) {
      res += ", anonymous user";
    } else {
      res += ", pseudo: ${this.pseudo}, email: ${this.email}";
    }
    return res;
  }
}
