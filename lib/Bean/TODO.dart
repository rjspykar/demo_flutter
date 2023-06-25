import 'dart:convert';
import 'package:http/http.dart' as http;

List<TODO> welcomeFromJson(String str) =>
    List<TODO>.from(json.decode(str).map((x) => TODO.fromJson(x)));

String welcomeToJson(List<TODO> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TODO {
  late int id;
  late String description;
  late bool isCompleted;
  DateTime dateTime = DateTime.now();

  static int counter = 1;

  TODO();
  TODO.allArgs(
    this.id,
    this.description,
    this.isCompleted,
    this.dateTime,
  );

  TODO.init(
    String desc,
  ) {
    id = counter++;
    description = desc;
    isCompleted = false;
  }

  Future<List<TODO>> getAllTODOList() async {
    final client = http.Client();
    var response =
        await client.get(Uri.parse("http://localhost:8080/getTODOs"));

    String todolist = response.body;
    return jsonDecode(todolist);
  }

  dynamic save(TODO todo) async {
    var client = http.Client();
    var todostr = jsonEncode(todo);

    print("in save");

    var response = await client.post(Uri.parse("http://localhost:8080/addTODO"),
        body: todostr,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });

    var body = response.body;
    var status = response.statusCode;

    if (status != 201) {
      return Future.error('Server error: $status $body');
    } else {
      return jsonDecode(body);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'isCompleted': isCompleted,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  factory TODO.fromJson(Map<String, dynamic> json) {
    return TODO.allArgs(
      json['id'],
      json['description'],
      json['isCompleted'],
      DateTime.parse(json['dateTime']),
    );
  }

/*
    SharedPreferences sp = await SharedPreferences.getInstance();
    String str = jsonEncode(todo);
    List<String>? todolist = sp.getStringList("todos");

    bool flag = true;
    for (int i = 0; i < todolist!.length; ++i) {
      TODO item = jsonDecode(todolist[i]);
      if (item.id == todo.id) {
        item.description = todo.description;
        item.isCompleted = todo.isCompleted;
        todolist[i] = jsonEncode(item);
        flag = false;
        break;
      }
    }
    if (flag) todolist!.add(str);
    sp.setStringList("todos", todolist);
  }
  */
}
