import 'package:flutter/material.dart';
import '../Bean/chatGPTBean.dart';

class ChatGPTResultCard extends StatefulWidget {
  final ChatGPTBean chatgptbean;

  const ChatGPTResultCard({super.key, required this.chatgptbean});

  @override
  State<ChatGPTResultCard> createState() => _ChatGPTResultCardState();
}

class _ChatGPTResultCardState extends State<ChatGPTResultCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.chatgptbean.textmsg),
        Text(widget.chatgptbean.resultmsg)
      ],
    );
  }
}
