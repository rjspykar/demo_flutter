import 'dart:convert';
import 'package:http/http.dart' as http;

class TODO implements Comparable<TODO> {
  late int id;
  late String description;
  late bool completed = false;
  DateTime dateTime = DateTime.now();

  static int counter = 1;

  TODO();
  TODO.allArgs(
    this.id,
    this.description,
    this.completed,
    this.dateTime,
  );

  @override
  int compareTo(dynamic other) {
    if (other is TODO) {
      return this.description.compareTo(other.description);
    } else {
      throw Exception('Cannot compare TODO with other');
    }
  }

  // This operator overload allows you to access the value of a property in a TODO object using the [] operator.
  dynamic operator [](String key) {
    switch (key) {
      case 'id':
        return id;
      case 'description':
        return description;
      case 'completed':
        return completed;
      case 'dateTime':
        return dateTime;
      default:
        throw ArgumentError('Invalid property: $key');
    }
  }

  TODO.init(
    String desc,
  ) {
    id = counter++;
    description = desc;
    completed = false;
  }
/*
  Future<List<TODO>> getAllTODOList() async {
    final client = http.Client();
    var response =
        await client.get(Uri.parse("http://localhost:8080/getTODOs"));

    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Future<List<TODO>>;
    } else {
      throw Exception('Failed to get TODO list');
    }
  }
  */

  Future<List<TODO>> getAllTODOList() async {
    final client = http.Client();
    var response =
        await client.get(Uri.parse("http://localhost:8080/getTODOs"));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var todos = List<TODO>.from(jsonData.map((todo) => TODO.fromJson(todo)));
      return todos;
    } else {
      throw Exception('Failed to get TODO list');
    }
  }

  Future<TODO> save(TODO todo) async {
    var client = http.Client();
    var todostr = jsonEncode(todo);

    print("in save ||" + todostr);

    var response = await client.post(Uri.parse("http://localhost:8080/addTODO"),
        body: todostr,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });

    var body = response.body;
    var status = response.statusCode;

    print("body:  " + body);

    if (status != 201) {
      throw Exception("Cannot add item");
    } else {
      return TODO.fromJson(jsonDecode(body));
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'completed': completed,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  factory TODO.fromJson(Map<String, dynamic> json) {
    return TODO.allArgs(
      json['id'],
      json['description'],
      json['completed'],
      DateTime.parse(json['dateTime']),
    );
  }
}
