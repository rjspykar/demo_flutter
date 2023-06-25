import 'package:flutter/material.dart';

import 'profile_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ignore: unused_field/*  */
  /*
  int _counter = 0;

  List<Welcome> arr = [];
Í
   void _incrementCounter() async {
    var url = Uri.parse("https://fakestoreapi.com/products");
    var response = await http.get(url);
    //print(response);
    final productModelTemp = welcomeFromJson(response.body);
    setState(() {
      // This call to setState tells the Flutter framework that something has
      arr = productModelTemp;
      _counter++;
    });
  } */

  Widget getButton() {
    return TextButton(onPressed: () {}, child: const Text("Ok"));
  }

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("My title"),
    content: const Text("This is my message."),
    actions: [
      TextButton(
        child: const Text("OK"),
        onPressed: () {},
      ),
    ],
  );

  // show the dialog
/*
  Widget? showDetail(int? id) {
    return OutlinedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
        },
        child: const Text(
          "Show\nDetails",
          textAlign: TextAlign.center,
        ));
  }
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }
*/

  @override
  Widget build(BuildContext context) {
    FutureBuilder(
      //future: _initializeFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          //return const MyHomePage(title: "Umang");
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    return const ProfileScreen();
    /*
    _incrementCounter();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: arr.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.greenAccent,
                          child: Text("${arr[index].id}"),
                        ),
                        title: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            arr[index].title.toString(),
                          ),
                        ),
                        subtitle: Card(
                          shadowColor: Colors.amberAccent,
                          color: const Color.fromARGB(255, 212, 214, 215),
                          child: Column(
                            children: [
                              Text(arr[index].category.toString()),
                              Text(arr[index].description.toString()),
                            ],
                          ),
                        ),
                        trailing: showDetail(arr[index].id),
                      );
                    }),
              ),
            ],
          ),
        ));
        */
  }
}
