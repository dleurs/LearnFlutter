import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/services.dart';

import 'package:my_flutter_app/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User.anonymous(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged
      .map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
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

  static String getExceptionText(Exception e) {
    if (e is PlatformException) {
      switch (e.message) {
        case 'There is no user record corresponding to this identifier. The user may have been deleted.':
          return 'User with this email address not found.';
          break;
        case 'The password is invalid or the user does not have a password.':
          return 'Invalid password.';
          break;
        case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          return 'No internet connection.';
          break;
        case 'The email address is already in use by another account.':
          return 'This email address already has an account.';
          break;
        default:
          return 'Unknown error occured. (${e.message})';
      }
    } else {
      return 'Unknown error occured.';
    }
  }

}