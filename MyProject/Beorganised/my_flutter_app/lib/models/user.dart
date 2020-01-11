//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:my_flutter_app/utils/database.dart';

class User {
  final String uid;
  bool databaseUserInfoLoaded = false;
  String pseudo;
  String email;

  User({@required this.uid});

  bool get isAnonymous {
    return (pseudo == null && email == null);
  }

  Future updateUser() async {
    Map<String, dynamic> dataUserFirestore =
        await DatabaseService(uid: uid).getUserFirestore();
    print(dataUserFirestore);
    this.pseudo = dataUserFirestore["pseudo"] ?? null;
    this.email = dataUserFirestore["email"] ?? null;
    this.databaseUserInfoLoaded = true;
  }

  String toString() {
    String res = "uid: ${this.uid}";
    if (this.isAnonymous) {
      res += ", anonymous user";
    } else {
      res += ", pseudo: ${this.pseudo}, email: ${this.email}";
    }
    return res;
  }
}
