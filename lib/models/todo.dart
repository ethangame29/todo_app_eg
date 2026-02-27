class Todo {
  final String name;
  final String description;
  final bool complete;


  Todo({required this.name, required this.description, this.complete = false});

  //Todo.specialCreation(this.nam, this.description, this.complete)


  @override
  String toString() {
    return '$name - ($description) [${complete ? 'Complete' : 'Not Complete'}]';
  }
}
