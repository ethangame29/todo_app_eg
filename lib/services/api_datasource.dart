import '../models/todo.dart';
import 'datasource.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import '../firebase_options.dart';

class ApiDatasource implements IDataSource{

  late FirebaseDatabase _database;

  Future initialise() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );
    _database = FirebaseDatabase.instance;
  }

  static Future<IDataSource> createAsync() async {
    ApiDatasource datasource = ApiDatasource();
    await datasource.initialise();
    return datasource;
  }

  @override
  Future<bool> add(Todo todo) async {
    DatabaseReference ref = _database.ref('todos').push();
    Map todoMap = todo.toMap();
    todoMap['id'] = ref.key;
    ref.set(todoMap);
    return true;
  }

  @override
  Future<List<Todo>> browse() async {
    final DataSnapshot snapshot = await _database.ref('todos').get();
    if(!snapshot.exists){
      throw Exception(
        'Invalid Request - Cannot find Snapshot: ${snapshot.ref.path}',
      );
    }
    
    return (snapshot.value as Map).values
      .map((e) => Map<String,dynamic>.from(e))
      .map((e) => Todo.fromMap(e))
      .toList();
  }

  @override
  Future<bool> delete(Todo todo) async {
    await _database.ref('todos/${todo.id}').remove();
    return true;
  }

  @override
  Future<bool> edit(Todo todo) async {
    await _database.ref('todos/${todo.id}').update(todo.toMap());
    return true;
  }

  @override
  Future<Todo?> read(String id) async {
    final DataSnapshot snapshot = await _database.ref().child('todos/$id').get();
    if(!snapshot.exists){
      throw Exception(
        'Invalid Request - Cannot find Snapshot: ${snapshot.ref.path}',
      );
    }

    return snapshot.value as Todo;
  }
}