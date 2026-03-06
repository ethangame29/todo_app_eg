class Todo {
  final String name;
  final String description;
  final bool complete;


  Todo({required this.name, required this.description, this.complete = false});

  //Todo.specialCreation(this.name, this.description, this.complete)

  @override
  String toString() {
    return '$name - ($description) [${complete ? 'Complete' : 'Not Complete'}]';
  }

  Todo copyWith({String? name, String? description, bool? complete}) {
    return Todo(
      name: name ?? this.name, 
      description: description ?? this.description,
      complete: complete ?? this.complete,
    );
  }
}
