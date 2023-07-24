import 'package:demo_flutter/Bean/ChatGPTBean.dart';
import 'package:demo_flutter/controllers/ChatGPTAPI.dart';
import 'package:flutter/material.dart';

import 'ChatGPTResultCard.dart';

class ChatGPTScreen extends StatefulWidget {
  ChatGPTScreen({super.key});
  final List<ChatGPTBean> list = [];

  @override
  State<ChatGPTScreen> createState() => _ChatGPTScreenState();
}

var inputController = TextEditingController();

class _ChatGPTScreenState extends State<ChatGPTScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat GPT"),
      ),
      body: ListView.builder(
          itemCount: widget.list.length,
          itemBuilder: (context, index) {
            return ChatGPTResultCard(chatgptbean: widget.list[index]);
          }),
      persistentFooterButtons: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: inputController,
                decoration: const InputDecoration(
                  hintText: 'Enter search term',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => sendToChatGPTAPI(inputController.text),
              child: const Text('Search'),
            ),
          ],
        )
      ],
    );
  }

  void sendToChatGPTAPI(String senderMsg) async {
    String response = await ChatGPTAPI.sendMessage(senderMsg);

    print(response);

    ChatGPTBean bn = ChatGPTBean(textmsg: senderMsg, resultmsg: response);
    setState(() {
      widget.list.add(bn);
    });
  }
}
