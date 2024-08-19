import 'package:flutter/material.dart';

import '../Bean/user.dart';
import 'todo_list.dart';

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
//    AuthController auth = AuthController();
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
            SizedBox(
              width: double.infinity,
              child: RawMaterialButton(
                padding: const EdgeInsets.symmetric(vertical: 12),
                elevation: 0,
                onPressed: () async {
/*
                  auth.loginUser(email.text, password.text);

                  */
                  User? user = await loginUsingEmailPassword(
                      email: email.text,
                      password: password.text,
                      buildContext: context);

                  if (user == null) {
                    SnackBar snackBar = const SnackBar(
                      content: Text("Invalid Email and Password"),
                      duration: Duration(seconds: 2),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    Navigator.pushReplacementNamed(context, '/home');

                    /*
                    showDialog(
                      context: context,
                      builder: (tcontext) => (AlertDialog(
                        //title: const Text("My title"),
                        title: const Text("Invalid Credentials"),
                        actions: [
                          TextButton(
                            child: const Text("OK"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      )),
                    );

                    */
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
                    builder: (context) => TODOListScreen(),
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
    User? user;
    try {
      var user = User(email, password);

      if (email == 'abc' && password == '123') return user;
    } on Exception catch (e) {
      print(e);
    }
    return user;
  }
}
