import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_flutter_app/models/todo.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});  

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

  Stream<List<Todo>> todosDefaultTodoGroupUser(String userUid) {
    return Firestore.instance.collection('todoLists').document(userUid).collection('todos').snapshots().map(_todoListFromSnapshot);
  }
}
