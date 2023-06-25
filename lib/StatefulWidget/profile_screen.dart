import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Bean/TODO.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<TODO> todoList = [
    TODO.init('Buy milk'),
    TODO.init('Do laundry'),
    TODO.init('Clean the house'),
  ];

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
            value: todo.isCompleted,
            title: getText(todo.description),
            subtitle:
                getText(DateFormat('MMMM d, yyyy hh:mm').format(todo.dateTime)),
            onChanged: (bool? value) {
              setState(() {
                todo.isCompleted = value!;
              });
              sort();
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTODO,
        tooltip: 'Add TODO',
        child: const Icon(Icons.add),
      ),
    );
  }

  TextEditingController descController = TextEditingController();

  Future<void> _addTODO() async {
    TODO todo = TODO.init(descController.text);
    final res = await TODO().save(todo);

    print("printing res");
    print(res);

    if (res != null) {
      todoList.add(res);
      setState(() {});
      sort();
      SnackBar snackBar = const SnackBar(
        content: Text('Successful'),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      SnackBar snackBar = const SnackBar(
        content: Text('Error occured'),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    super.initState();
    todoList.clear();
  }

  Widget getText(String message) {
    return Text(message);
  }

  void sort() {
    todoList.sort((a, b) => a.isCompleted == b.isCompleted
        ? -1 * a.dateTime.compareTo(b.dateTime)
        : a.isCompleted
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

  void func(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add TODO'),
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
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              child: Text("Add"),
              onPressed: _addTODO,
            )
          ],
        );
      },
    );
  }
}
