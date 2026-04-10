import 'package:todo_app_eg/models/todo_list.dart';

import '../models/todo.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './datasource.dart';

class HiveDatasource implements IDataSource{
  
  Future initialise() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TodoAdapter());
    await Hive.openBox<Todo>('todos');
    //await Hive.deleteBoxFromDisk('todos');
  }

  static Future<IDataSource> createAsync() async {
    
    HiveDatasource datasource = HiveDatasource();
    await datasource.initialise();
    return datasource;
    //return await HiveDatasource().initialise();
  }

  @override
  Future<bool> add(Todo todo) async {
    Box<Todo> box = Hive.box('todos');
    int id = await box.add(todo);
    await edit(todo.copyWith(id: id.toString()));
    return true;
  }

  @override
  Future<List<Todo>> browse() async {
    Box<Todo> box = Hive.box('todos');
    return box.values.toList();
  }

  @override
  Future<bool> delete(Todo todo) async {
    Box<Todo> box = Hive.box('todos');
    await box.delete(int.parse(todo.id));
    return true;
  }

  @override
  Future<bool> edit(Todo todo) async {
    Box<Todo> box = Hive.box('todos');
    await box.put(int.parse(todo.id), todo);
    return true;
  }

  @override
  Future<Todo?> read(String id) async {
    Box<Todo> box = Hive.box('todos');
    return box.get(id);
  }

}