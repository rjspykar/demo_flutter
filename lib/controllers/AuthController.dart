import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthController {
  Future loginUser(String userid, String password) async {
    const url = 'http://10.0.2.2:8080';

    var response = await http.post(
      Uri.parse(url),
      body: json.encode({
        "username": userid,
        "password": password,
      }),
    );

    while (response == null) {
      print("nu");
    }

    if (response.statusCode == 200) {
      var loginArr = json.decode(response.body);
      print(loginArr);
    } else {
      print("login error");
    }
  }
}
