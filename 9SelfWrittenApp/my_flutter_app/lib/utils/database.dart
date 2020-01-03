import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_flutter_app/models/todo.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference todoCollection =
      Firestore.instance.collection('todos');

  List<Todo> _todoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      //print(doc.data);
      return Todo(
        name: doc.data['name'] ?? 'No name',
        description: doc.data['description'] ?? null,
        creatorUid: doc.data['creatorUid'] ?? 'No creator',
        isDone: doc.data['isDone'] ?? null,
      );
    }).toList();
  }

  Stream<List<Todo>> get todos {
    return todoCollection.snapshots().map(_todoListFromSnapshot);
  }
}
