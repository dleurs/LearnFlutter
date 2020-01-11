import 'dart:io';

import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/services.dart';

import 'package:my_flutter_app/models/user.dart';
import 'package:my_flutter_app/utils/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    User userUser = User(uid: user.uid);
    userUser.updateUser();
    return userUser;
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

    static Future signInWithEmailAndPassword({String email, String password}) async {
    try {
      AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      sleep(Duration(seconds: 1));
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  // register with email and password
    static Future registerWithEmail(
      {String pseudo, String email, String password}) async {
    try {
      FirebaseUser user = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password))
          .user;
      await DatabaseService(uid: user.uid)
          .updateUserData(pseudo: pseudo, email: email);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

   static Future convertFromAnonToEmail(
      {String pseudo, String email, String password}) async {
    final currentUser = await FirebaseAuth.instance.currentUser();
    final credential =
        EmailAuthProvider.getCredential(email: email, password: password);
    currentUser.linkWithCredential(credential);
    await DatabaseService(uid: currentUser.uid)
        .updateUserData(pseudo: pseudo, email: email);
    //var docUser = await Firestore.instance.collection('users').document(user.uid).get();
  }

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
