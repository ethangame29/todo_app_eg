import 'package:flutter/material.dart';
import './models/todo.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: TodoHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final List<Todo> todos = [
    Todo(name: 'Get Food', description: 'Stand in front of fridge for 10 minutes and decide i dont want anything in there ghahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahahasasssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssf'),
    Todo(name: 'Solve world hunger', description: 'Dont use fridge'),
    Todo(name: 'Catch the fridge', description: 'We are going to need a bigger boat', complete: true),
  ];

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Fancy Todo App'), 
        backgroundColor: Theme.of(context).primaryColorLight,
      ),
      body: Center(
        child: ListView.builder(itemCount: todos.length, itemBuilder: (context, index) {
          return Card(
            color: todos[index].complete ? Colors.cyan : Colors.blueGrey,
            child: Padding(
              padding: const EdgeInsets.all(8),
              
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(todos[index].name, style: Theme.of(context).textTheme.headlineSmall),
                        Text(todos[index].description, style: Theme.of(context).textTheme.labelMedium,),
                      ],
                    ), 
                  ),

                  Checkbox(value: todos[index].complete, onChanged: (value) {}),
                ],
              ),
            ),
          );
        },),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTodo, 
        child: Icon(Icons.add),
      ),
    );
  }

  void _openAddTodo(){
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(5, 8, 5, 0),
              child: Text('Name'),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 8, 5, 0),
              child: TextFormField(controller: _controllerName),
            ),

            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(5, 8, 5, 0),
              child: Text('Description'),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 8, 5, 0),
              child: TextFormField(controller: _controllerDescription),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
          ],
        ),
        actions: [
          ElevatedButton(onPressed: (){
              setState(() {
                todos.add(
                  Todo(
                    name: _controllerName.text,
                    description: _controllerDescription.text,
                  ),
                );
              });
              Navigator.pop(context);
              _controllerName.clear();
              _controllerDescription.clear();
            },
            child: const Text('Add')
            ),
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
              _controllerName.clear();
              _controllerDescription.clear();
            },
            child: const Text('Cancel')
            )
        ],
      );
    },);
  }

}
