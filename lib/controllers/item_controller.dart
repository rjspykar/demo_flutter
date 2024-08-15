import 'package:demo_flutter/Bean/item.dart';
import 'package:http/http.dart' as http;

class ItemController {
  Future<List<Product>> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://602fc537a1e9d20017af105e.mockapi.io/api/v1/products'));

    if (response.statusCode == 200) {
      final data = productsFromJson(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
