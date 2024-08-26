import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Bean/todo.dart';

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
//edit
void showEditTODODialog(TODO todo) {
    TextEditingController descController = TextEditingController(text: todo.description);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit TODO'),
          content: TextField(
            controller: descController,
            decoration: const InputDecoration(
              labelText: 'Description',
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              onPressed: () {
                _updateTODODescription(todo, descController.text);
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
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

          return ListTile(
            onTap: () => showEditTODODialog(todo),
          title: CheckboxListTile(
            selected: todo.completed,
            value: todo.completed,
            title: getText(todo.description),
            subtitle: getText(DateFormat('MMMM d, yyyy hh:mm').format(todo.dateTime)),
            onChanged: (bool? value) {
              setState(() {
                todo.completed = value!;
                updateTODO(todo);
              });
            },
          ),
        trailing:  IconButton(
              icon: const Icon(Icons.delete),
              onPressed: (){
                _deleteTODO(todo);
              },
            )
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
  //delete
  void _deleteTODO(TODO todo) {
  // Send DELETE request to backend with the TODO object
  TODO().delete(todo).then((success) {
    if (success) {
      setState(() {
        todoList.remove(todo);
        sort();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('TODO item successfully deleted'),
            duration: Duration(seconds: 2),
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to delete TODO item'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  });
}



//update
void _updateTODODescription(TODO todo, String newDescription) {
    setState(() {
        todo.description = newDescription;
        updateTODO(todo); // This will send the entire TODO object to the backend
        
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