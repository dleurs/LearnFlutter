import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/services.dart';

import 'package:my_flutter_app/models/user.dart';
import 'package:my_flutter_app/utils/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User> _userFromFirebaseUser(FirebaseUser user) async {
    if (user != null) {
      if (user.isAnonymous) {
        return User.anonymous(uid: user.uid);
      } else {
        var docUser = await Firestore.instance.collection('users').document(user.uid).get();
        return User.fromDocument(docUser:docUser);
      }
    }
    return null;
  }

  Stream<Future<User>> get user {
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).updateUserData();
      return _userFromFirebaseUser(user);
    } catch (e) {
      //print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  static Future<String> signIn({String email, String password}) async {
    FirebaseUser user = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password))
        .user;
    return user.uid;
  }

  // register with email and password, without being anonymously connected
  static Future<User> registerWithEmail(
      {String pseudo, String email, String password}) async {
    try {
      FirebaseUser user = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password))
          .user;
      await DatabaseService(uid: user.uid)
          .updateUserData(pseudo: pseudo, email: email);
      return User(uid: user.uid, pseudo: pseudo, email: email);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // regi
  static Future<User> convertFromAnonWithEmail(
      {String pseudo, String email, String password}) async {
    final currentUser = await FirebaseAuth.instance.currentUser();
    final credential =
        EmailAuthProvider.getCredential(email: email, password: password);
    currentUser.linkWithCredential(credential);
    await DatabaseService(uid: currentUser.uid)
        .updateUserData(pseudo: pseudo, email: email);
    //var docUser = await Firestore.instance.collection('users').document(user.uid).get();

    return User(uid: currentUser.uid, pseudo: pseudo, email: email);
  }

  //

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
