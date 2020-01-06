import "package:firebase_auth/firebase_auth.dart";

import 'package:my_flutter_app/models/user.dart';
import 'package:my_flutter_app/utils/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged
      .map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  // sign in anon
  
  Future signInAnonymous() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      DatabaseService(uid:user.uid).updateUserData();
      return _userFromFirebaseUser(user);
    } catch (e) {
      //print(e.toString());
      return null;
    }
  }


  // sign in with email and password

  // register with email and password

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      //print(error.toString());
      return null;
    }
  }

}