//this my state object
import 'dart:collection';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app_eg/services/datasource.dart';
import './todo.dart';

class TodoList extends ChangeNotifier {
  final List<Todo> _todos = [];


  UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);

  int get todoCount => _todos.length;

  int get todoCompleted => _completed();

  Future<List<Todo>> refresh() async {
    IDataSource dataSource = Get.find();
    _todos.clear();
    _todos.addAll(await dataSource.browse());
    notifyListeners();
    return _todos;
  }

  Future add(Todo todo) async {
    IDataSource dataSource = Get.find();
    await dataSource.add(todo);
    await refresh();
  }

  void removeAll() {
    _todos.clear();
    notifyListeners();
    //Might never use this?
  }

  void remove(Todo todo) {
    _todos.remove(todo);
    notifyListeners(); 
    //Calling change notifiers notify listeners will allow anyone listening to the object state
    //to know something has been updated and might need reflected (or redrawn) on the UI.
  }

  int _completed() {
    int completedTasks = 0;
    for (var task in _todos) {
      if (task.complete == true) {
        completedTasks += 1;
      }
    }
    return completedTasks;
  }

  void updateTodo(Todo todo) async {
    //Todo listTodo = _todos.firstWhere(
    //  (t) => t.name == todo.name,
    //);
    //int index = _todos.indexOf(
    //  listTodo
    //); // We dont have the id or an identifier yet
    
    //_todos[index] = todo;
    
    IDataSource dataSource = Get.find();
    await dataSource.edit(todo);
    await refresh();
  }
}
