import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_flutter_app/models/todo.dart';
import 'package:my_flutter_app/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  Future<void> updateUserData({String pseudo, String email}) async {
    if (pseudo != null && email != null) {
      return await Firestore.instance
          .collection('users')
          .document(uid)
          .setData({
        'uid': uid,
        'pseudo': pseudo,
        'email': email,
        'dateRegisterEmail': DateTime.now(),
      });
    } else {
      return await Firestore.instance
          .collection('users')
          .document(uid)
          .setData({
        'uid': uid,
        'uidAnon': uid,
        'dateRegisterAnonymous': DateTime.now(),
      });
    }
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

  Stream<List<Todo>> todosFromDefaultTodoList(String userUid) {
    return Firestore.instance
        .collection('todoLists')
        .document(userUid)
        .collection('todos')
        .snapshots()
        .map(_todoListFromSnapshot);
  }
}
