import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthController {
  Future loginUser(String userid, String password) async {
    const url = 'http://10.64.25.150:8080';

    var response = await http.post(
      Uri.parse(url),
      body: json.encode({
        "username": userid,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      var loginArr = json.decode(response.body);
    } else {}
  }

// Register a new user
  Future<UserCredential?> registerWithEmailAndPassword(
      String email, String password) async {
    return null;

    /* try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    } */
  }

// Sign in an existing user
  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    return null;

    /* try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    } */
  }
}

class UserCredential {
  get user => null;
}
