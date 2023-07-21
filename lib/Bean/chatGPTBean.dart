class ChatGPTBean {
  final String textmsg;
  final String resultmsg;
  ChatGPTBean({
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



//CharGPT API Key :     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