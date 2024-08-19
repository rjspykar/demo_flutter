import 'package:demo_flutter/StatefulWidget/todo_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs extends StatelessWidget {
  final String name = "";

  const SharedPrefs({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SharedPreferences Example'),
        ),
        body: Center(
          child: Column(
            children: [
              const Text('Your name is:'),
              FutureBuilder(
                future: getName(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(const TODOListScreen().toString());
                  } else {
                    return const Text('Loading...');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('name');
    name ??= 'John Doe';
    return name;
  }

  void setName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
  }
}
