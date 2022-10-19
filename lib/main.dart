import 'package:demo_flutter/controllers/AuthController.dart';
import 'package:demo_flutter/productmodel.dart';
import 'package:demo_flutter/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
    );
  }
}

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
*/
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    body:
    FutureBuilder(
      future: _initializeFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done)
          return LoginPage();
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    return LoginPage();
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

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthController auth = AuthController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "App Title",
              style: TextStyle(
                  fontSize: 28,
                  backgroundColor: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Login to your App",
              style: TextStyle(fontSize: 32, backgroundColor: Colors.white),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: email,
              decoration: const InputDecoration(
                fillColor: Colors.blueAccent,
                hintText: "User Email Id",
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.black,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(
                fillColor: Colors.blueAccent,
                hintText: "User Password",
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                padding: const EdgeInsets.symmetric(vertical: 12),
                elevation: 0,
                onPressed: () async {
                  auth.loginUser(email.text, password.text);

/*
                  User? user = await loginUsingEmailPassword(
                      email: email.text,
                      password: password.text,
                      buildContext: context);
                  print("dada:  ${user}");
                  if (user != null) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ));
                  } else {
                    showDialog(
                      context: context,
                      builder: (tcontext) => (AlertDialog(
                        //title: const Text("My title"),
                        title: const Text("Invalid Credentials"),
                        actions: [
                          TextButton(
                            child: const Text("OK"),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                          ),
                        ],
                      )),
                    );
                  }


                  */
                },
                fillColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

/*
  Padding Login() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "App Title",
            style: TextStyle(
                fontSize: 28,
                backgroundColor: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Login to your App",
            style: TextStyle(fontSize: 32, backgroundColor: Colors.white),
          ),
          const SizedBox(
            height: 30,
          ),
          TextField(
            controller: email,
            decoration: const InputDecoration(
              fillColor: Colors.blueAccent,
              hintText: "User Email Id",
              prefixIcon: Icon(
                Icons.email,
                color: Colors.black,
              ),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: password,
            obscureText: true,
            decoration: const InputDecoration(
              fillColor: Colors.blueAccent,
              hintText: "User Password",
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black,
              ),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            width: double.infinity,
            child: RawMaterialButton(
              padding: const EdgeInsets.symmetric(vertical: 12),
              elevation: 0,
              onPressed: () async {
                User? user = await loginUsingEmailPassword(
                    email: email.text,
                    password: password.text,
                    buildContext: context);
                print("dada:  ${user}");
                if (user != null) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ));
                } else {
                  showDialog(
                    context: context,
                    builder: (tcontext) => (AlertDialog(
                      title: const Text("My title"),
                      content: const Text("This is my message."),
                      actions: [
                        TextButton(
                          child: const Text("OK"),
                          onPressed: () {},
                        ),
                      ],
                    ),)
                  );
                }
              },
              fillColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Login",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
*/
  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext buildContext}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No email for user");
      }
    }
    return user;
  }
}
