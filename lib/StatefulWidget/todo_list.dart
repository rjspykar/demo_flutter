import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Bean/todo.dart';

class TODOListScreen extends StatefulWidget {
  const TODOListScreen({super.key});

  @override
  _TODOListScreenState createState() => _TODOListScreenState();
}

class _TODOListScreenState extends State<TODOListScreen> {
  List<TODO> todoList = [];
  int totalChecked = 0;

  void func(context) {
    TextEditingController descController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add TODO'),
          content: Column(
            children: [
              TextField(
                controller: descController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
              ),
            ],
          ),
          actions: [
            MaterialButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              onPressed: () {
                _addTODO(descController);
                Navigator.of(context).pop();
              },
              child: const Text("Add"),
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // Initialize the state of the widget's properties.
    // Register listeners for events.
    // Make asynchronous requests.
    Future<List<TODO>> res = TODO().getAllTODOList();
    res.then((value) {
      setState(() {
        for (var element in value) {
          if (element.completed) {
            totalChecked++;
          }
        }

        todoList.addAll(value);
        sort();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: getText('TODO List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              await prefs.setBool('isLoggedIn', false);

              // Navigate back to the login page
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          TODO todo = todoList[index];

          return CheckboxListTile(
            selected: todo.completed,
            value: todo.completed,
            title: getText(todo.description),
            subtitle:
                getText(DateFormat('MMMM d, yyyy hh:mm').format(todo.dateTime)),
            onChanged: (bool? value) {
              todo.completed = value!;

              updateTODO(todo);

              //todo.completed = value;

              //sort();
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          func(context);
        },
        tooltip: 'Add TODO',
        child: const Icon(Icons.add),
      ),
      persistentFooterButtons: [
        TextButton(
            onPressed: () {},
            child: Text("Total Completed Tasks: $totalChecked"))
      ],
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
    );
  }

  SnackBar successSnackBar = const SnackBar(
    content: Text('Successful'),
    duration: Duration(seconds: 2),
  );

  SnackBar failureSnackBar = const SnackBar(
    content: Text('Add TODO failed'),
    duration: Duration(seconds: 2),
  );

  void updateTODO(TODO todo) {
    Future<bool> result = TODO().update(todo);

    result.then((value) {
      if (todo.completed) {
        setState(() {
          totalChecked++;
        });
      } else {
        setState(() {
          totalChecked--;
        });
      }
    });
  }

  void _addTODO(TextEditingController descController) {
    TODO todo = TODO.init(descController.text);
    TODO().save(todo).then((savedTodo) {
      setState(() {
        todoList.add(savedTodo);
        sort();
      });
      ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(failureSnackBar);
    });
  }

  Widget getText(String message) {
    return Text(message);
  }

  void sort() {
    todoList.sort((a, b) => a.completed == b.completed
        ? -1 * a.dateTime.compareTo(b.dateTime)
        : a.completed
            ? 1
            : -1);
  }
}
