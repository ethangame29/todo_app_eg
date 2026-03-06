import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_eg/models/todo_list.dart';
import '../models/todo.dart';

class TodoWidget extends StatefulWidget {
  final Todo todo;
  const TodoWidget({super.key, required this.todo});

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
            color: widget.todo.complete ? Colors.cyan : Colors.blueGrey,
            child: Padding(
              padding: const EdgeInsets.all(8),
              
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          widget.todo.name,
                          style: Theme.of(context).textTheme.headlineSmall
                          ),
                        Text(
                          widget.todo.description, 
                          style: Theme.of(context).textTheme.labelMedium,
                          ),
                      ],
                    ), 
                  ),

                  Checkbox(value: widget.todo.complete, onChanged: (value) {
                    Provider.of<TodoList>(context,listen: false).updateTodo(
                      widget.todo.copyWith(complete: value)
                    );
                  }),
                ],
              ),
            ),
          );
  }
}