import '../models/todo.dart';
import './datasource.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDatasource implements IDataSource {

  late Database _database;

  Future initialise() async {

    _database = await openDatabase(
      join(await getDatabasesPath(), 'todo_data.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute('CREATE TABLE IF NOT EXISTS todos (id INTEGER PRIMARY KEY, name TEXT, description TEXT, complete INTEGER)');
      },
    );
  }

  static Future<IDataSource> createAsync() async {
    //await deleteDatabase(join(await getDatabasesPath(), 'todo_data.db'));
    SqlDatasource datasource = SqlDatasource();
    await datasource.initialise();
    return datasource;
  }

  @override
  Future<bool> add(Todo todo) async {
    Map<String,dynamic> editiedMap = todo.toMap();
    editiedMap.remove('id');

    //This below statement remove returns the value of id not the resulting map
    //todo.toMap().remove('id')
    
    return await _database.insert('todos', editiedMap) != 0;
  }

  @override
  Future<List<Todo>> browse() async {
    List<Map<String,dynamic>> maps = await _database.query('todos');
    return List.generate(maps.length, (index) {
      return Todo.fromMap(maps[index]);
    },);
  }

  @override
  Future<bool> delete(Todo todo) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<bool> edit(Todo todo) {
    // TODO: implement edit
    throw UnimplementedError();
  }

  @override
  Future<Todo?> read(String id) {
    // TODO: implement read
    throw UnimplementedError();
  }
}
