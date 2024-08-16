import 'package:demo_flutter/StatefulWidget/login_page.dart';
import 'package:flutter/material.dart';

import '../StatelessWidget/product_list.dart';
import '../navbar.dart';
import 'todo_list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> list =
      List.from({"Alert Demo", "TODO List", "Product List", "Login Page"});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        title: const Text("HomePage AppBar"),
      ),
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            String datatext = list[index];
            return TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(56.0),
                  ),
                ),
                onPressed: () => handleButtonClick(context, datatext, index),
                child: Text(datatext));
          }),
      //ProfileScreen(),
      persistentFooterButtons: [
        OutlinedButton(onPressed: () {}, child: const Text("BUtton 1")),
        OutlinedButton(onPressed: () {}, child: const Text("BUtton 2")),
        OutlinedButton(onPressed: () {}, child: const Text("BUtton 3"))
      ],
      persistentFooterAlignment: AlignmentDirectional.center,
    );

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

  //Button click handler: Show snackbar
  handleButtonClick(BuildContext context, String datatext, int index) {
    if (index == 0) {
      SnackBar snackBar = SnackBar(
        content: Text(" $datatext pressed"),
        duration: const Duration(seconds: 1),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (index == 1) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()));
    } else if (index == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProductList()));
    } else if (index == 3) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

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
}
