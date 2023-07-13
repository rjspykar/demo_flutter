import 'dart:convert';

class chatGPTBean {
  final String textmsg;
  final String resultmsg;
  chatGPTBean({
    required this.textmsg,
    required this.resultmsg,
  });
}

// List<chatGPTBean> productsFromJson(String json) {
//   //print(json);
//   List<dynamic> parsedJson = jsonDecode(json);
//   return parsedJson
//       .map((json) =>
//           Product(textmsg: json['textmsg'], resultmsg: json['resultmsg']))
//       .toList();
// }
