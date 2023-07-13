import 'package:demo_flutter/Bean/chatGPTBean.dart';
import 'package:flutter/material.dart';
import '../Bean/chatGPTBean.dart';
import 'ChatGPTResultCard.dart';

class ChatGPTScreen extends StatefulWidget {
  ChatGPTScreen({super.key});
  List<chatGPTBean> list = [];

  @override
  State<ChatGPTScreen> createState() => _ChatGPTScreenState();
}

var inputcintroller = TextEditingController();

class _ChatGPTScreenState extends State<ChatGPTScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat GPT"),
      ),
      body: ListView.builder(
          itemCount: widget.list.length,
          itemBuilder: (context, index) {
            return ChatGPTResultCard(chatgptbean: widget.list[index]);
          }),
      persistentFooterButtons: [
        Row(
          children: [
            SizedBox(
              width: 600,
              child: TextField(
                controller: inputcintroller,
                decoration: const InputDecoration(
                    label: Text('Enter text.'), prefixIcon: Icon(Icons.search)),
              ),
            ),
            ElevatedButton(onPressed: () {}, child: Text("Go"))
          ],
        )
      ],
    );
  }
}
