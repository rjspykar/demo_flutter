/* import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
 */
import 'package:flutter/material.dart';

import 'StatelessWidget/my_app.dart';

void main() {
  runApp(const MyApp());
}

/*

Main function
  runApp ( -> Widget)

Widget
  Text, Button, Screen, Dropdown, etc.....
  Parent class.
  Text inherits Widget.

  2 types:
  Stateless widget.
    No state.
    Static.
  Stateful Widget.
    State.
    Value =1 -> 1 state
    Value=2 -> 2nd state.

    counter -> increment, decrement.
    change.


*/
/* *
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ignore: unused_field
  int _counter = 0;

  List<Welcome> arr = [];

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
  }

  Widget getButton() {
    return TextButton(onPressed: () {}, child: Text("Ok"));
  }

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("My title"),
    content: Text("This is my message."),
    actions: [
      TextButton(
        child: Text("OK"),
        onPressed: () {},
      ),
    ],
  );

  // show the dialog

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

  @override
  Widget build(BuildContext context) {
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

*  */

