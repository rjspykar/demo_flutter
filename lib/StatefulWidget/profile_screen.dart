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
        todoList.addAll(value);
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
            value: todo.completed,
            title: getText(todo.description),
            subtitle:
                getText(DateFormat('MMMM d, yyyy hh:mm').format(todo.dateTime)),
            onChanged: (bool? value) {
              setState(() {
                if (value!) {
                  totalChecked++;
                } else {
                  totalChecked--;
                }
                todo.completed = value;
              });
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

  void _addTODO(descController) async {
    TODO todo = TODO.init(descController.text);

    Future<TODO> todostr = TODO().save(todo);
    todostr.then((value) {});
    setState(() {
      todoList.add(todo);
      todoList.sort();
    });
    SnackBar snackBar = const SnackBar(
      content: Text('Successful'),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

/*
  void addTODO() {
    TextEditingController descController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: getText('Add TODO'),
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
              child: getText('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              child: getText("Add"),
              onPressed: () async {
                TODO todo = TODO.init(
                  descController.text,
                );
                Future<TODO> res = todo.save(todo);

                print(res);

                res.then((value) {
                  print("1");
                  print(value);

                  todoList.add(value);
                  SnackBar snackBar = const SnackBar(
                    content: Text('Successful'),
                    duration: Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.of(context).pop();
                }, onError: (value) {
                  print("2");
                  print(value);
                  SnackBar snackBar = const SnackBar(
                    content: Text('Error occured'),
                    duration: Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });

                /*
                setState(() {
                  todoList.add(res);
                });
                sort();
                */
              },
            )
          ],
        );
      },
    );
  }
*/
}
