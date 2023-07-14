import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatGPTAPI {
  static const String apiKey =
      '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';
  static const String endpoint = 'https://api.openai.com/v1/chat/completions';

  static Future<String> sendMessage(String message) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    final Map<String, dynamic> data = {
      'model': 'gpt-3.5-turbo',
      'messages': [
        {'role': 'system', 'content': 'You are a helpful assistant.'},
        {'role': 'user', 'content': message},
      ],
    };

    final response = await http.post(
      Uri.parse(endpoint),
      headers: headers,
      body: jsonEncode(data),
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final List<dynamic> replies =
          responseData['choices'][0]['message']['content'];
      return replies.join('\n');
    } else {
      throw Exception('Failed to send message to ChatGPT API.');
    }
  }
}
