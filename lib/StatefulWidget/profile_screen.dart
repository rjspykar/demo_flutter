import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Bean/TODO.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

              todo.completed = value;

              /*
              if (value!) {
                setState(() {
                  totalChecked++;
                });
              } else {
                totalChecked--;
              }
              todo.completed = value;
              //sort();
              */
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
      if (value) {
        setState(() {
          totalChecked++;
        });
      } else {
        totalChecked--;
      }
    });
  }

  void _addTODO(descController) async {
    TODO todo = TODO.init(descController.text);
    Future<TODO> todostr = TODO().save(todo);

    todostr.then((value) {
      setState(() {
        todoList.add(value);
        todoList.sort();
      });
    }).then((value) {
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
