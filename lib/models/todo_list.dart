//this my state object
import 'dart:collection';

import 'package:flutter/widgets.dart';
import './todo.dart';

class TodoList extends ChangeNotifier {
  final List<Todo> _todos = [
    Todo(name: 'Get Food', description: 'Stand in front of fridge for 10 minutes and decide i dont want anything in there ghahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahasasssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssf'),
    Todo(name: 'Solve world hunger', description: 'Dont use fridge'),
    Todo(name: 'Catch the fridge', description: 'We are going to need a bigger boat', complete: true),
  ];


  UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);

  int get todoCount => _todos.length;

  void add(Todo todo) {
    _todos.add(todo);
    notifyListeners();
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


  void updateTodo(Todo todo) {
    Todo listTodo = _todos.firstWhere(
      (t) => t.name == todo.name,
    );
    int index = _todos.indexOf(
      listTodo
    ); // We dont have the id or an identifier yet
    _todos[index] = todo;
    notifyListeners();
  }
}
