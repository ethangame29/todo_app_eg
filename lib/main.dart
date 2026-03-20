import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_eg/services/datasource.dart';
import '../services/hive_datasource.dart';

import './views/todo_widget.dart';
import './models/todo_list.dart';
import './models/todo.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.putAsync<IDataSource>(() =>HiveDatasource.createAsync()).whenComplete(
    () => runApp(
      ChangeNotifierProvider(
        create: (context) => TodoList(),
        child: const TodoApp(),
      )
    ),
  );
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

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Fancy Todo App'), 
        backgroundColor: Theme.of(context).primaryColorLight,
        actions: [
          Text('Tasks Completed: ${Provider.of<TodoList>(context,listen: true).todoCompleted.toString()} / ${Provider.of<TodoList>(context,listen: false).todoCount.toString()}'),
        ],
      ),
      body: Center(
        child: Consumer<TodoList>(
          builder: (
            BuildContext context, 
            TodoList stateObject, 
            Widget? child
            ) {
              return RefreshIndicator(
              onRefresh: stateObject.refresh, 
              child: ListView.builder(
                itemCount: stateObject.todos.length,
                itemBuilder: (context, index) {
                  return TodoWidget(todo: stateObject.todos[index]);
                }
              )
            );
            //return FutureBuilder(
            //  future: stateObject.refresh(),
            //  builder: (context, snapshot) {
            //    if (snapshot.connectionState == ConnectionState.done &&
            //      snapshot.hasData && snapshot.data != null) {
            //      return ListView.builder(
            //        itemCount: stateObject.todos.length, 
            //        itemBuilder: (context, index) {
            //          return TodoWidget(todo: stateObject.todos[index]);
            //        },
            //      );
            //    }
            //    if (snapshot.hasError) {
            //      return Center(child: Icon(Icons.error),);
            //    }
            //    return Center(
            //      child: CircularProgressIndicator(color: Colors.amber,),
            //    );
            //  }
            //);
          },
        )
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
                Provider.of<TodoList>(context,listen: false).add(
                  Todo(
                    id: '',
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
