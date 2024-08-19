import 'package:demo_flutter/StatefulWidget/login_page.dart';
import 'package:demo_flutter/StatefulWidget/todo_list.dart';
import 'package:flutter/material.dart';

import '../StatefulWidget/my_homepage.dart';

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({required this.isLoggedIn});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: isLoggedIn ? '/home' : '/login',
      routes: <String, WidgetBuilder>{
        '/home': (context) => const TODOListScreen(),
        '/about': (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('About Route'),
            ),
          );
        },
        '/login': (context) => const LoginPage(),
      },
    );
  }
}
