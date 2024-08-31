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
      return description.compareTo(other.description);
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

  Future<List<TODO>> getAllTODOList() async {
    final client = http.Client();
    try {
      var response =
          await client.get(Uri.parse("http://localhost:8080/getTODOs"));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        return List<TODO>.from(jsonData.map((todo) => TODO.fromJson(todo)));
      } else {
        throw Exception('Failed to get TODO list: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error fetching TODO list: $e');
    } finally {
      client.close();
    }
  }
//delete
Future<bool> delete(TODO todo) async {
  final client = http.Client();
  try {
    final response = await client.delete(
      Uri.parse("http://localhost:8080/deleteTODO"),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
      body: jsonEncode(todo.toJson()),
    );

    if (response.statusCode == 204) {
      return true;
    } else {
      return false; 
    }
  } catch (e) {
    throw Exception("Error deleting TODO: $e");
  } finally {
    client.close();
  }
}

  Future<bool> update(TODO todo) async {
    final client = http.Client();
    var todostr = jsonEncode(todo);

    var resp = await client.post(Uri.parse("http://localhost:8080/updateTODO"),
        body: todostr,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });

    //var body = resp.body;
    var status = resp.statusCode;

    if (status == 201) {
      //Created
      return true;
    } else if (status == 304) {
      //Not Modified
      return false;
    } else {
      throw Exception("Failed to update TODO");
    }
  }

  Future<TODO> save(TODO todo) async {
    var client = http.Client();
    var todostr = jsonEncode(todo);

    var response = await client.post(Uri.parse("http://localhost:8080/addTODO"),
        body: todostr,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });

    var body = response.body;
    var status = response.statusCode;

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
