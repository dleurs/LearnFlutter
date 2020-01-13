import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:my_flutter_app/models/todo.dart';
import 'package:my_flutter_app/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({@required this.uid});

  Stream<User> streamUser() {
    return Firestore.instance
        .collection('users')
        .document(uid)
        .snapshots()
        .map((snap) => User.fromMap(snap.data));
  }

  Future<User> getUser() {
    return Firestore.instance
        .collection('users')
        .document(uid)
        .get().then((doc) => User.fromMap(doc.data));
  }


  Future<void> updateUserData({@required String pseudo, @required String email}) async {
    return await Firestore.instance.collection('users').document(uid).setData({
      'uid': uid,
      'isAnonymous': false,
      'pseudo': pseudo,
      'email': email,
      'dateRegisterEmail': DateTime.now(),
    });
    //FirebaseAuth
  }

  Future<void> updateUserDataAnonymous() async {
    return await Firestore.instance.collection('users').document(uid).setData({
      'uid': uid,
      'isAnonymous': true,
      'dateRegisterAnonymous': DateTime.now(),
    });
    //FirebaseAuth
  }

  Future<Map<String, dynamic>> getUserFirestore() async {
    if (uid != null) {
      return Firestore.instance
          .collection('users')
          .document(uid)
          .get()
          .then((documentSnapshot) => documentSnapshot.data);
    } else {
      print('firestore user uid can not be null');
      return null;
    }
  }

  List<Todo> _todoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      //print(doc.data);
      return Todo(
        name: doc.data['name'] ?? 'No name',
        description: doc.data['description'] ?? null,
        creatorUid: doc.data['creatorUid'] ?? 'No creator',
        isDone: doc.data['isDone'] ?? false,
      );
    }).toList();
  }

  Stream<List<Todo>> todosFromDefaultTodoList() {
    return Firestore.instance
        .collection('todoLists')
        .document(uid)
        .collection('todos')
        .snapshots()
        .map(_todoListFromSnapshot);
  }
}
