import 'package:converse_gpt/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textController;
  final Function sendMessage;
  const CustomTextField({
    required this.textController,
    required this.sendMessage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey[800],
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              textAlign: TextAlign.start,
              controller: textController,
              onSubmitted: ((value) => sendMessage()),
              decoration: const InputDecoration(
                hintStyle: TextStyle(
                  fontSize: 17,
                  color: textColor,
                ),
                hintText: "Type a message!",
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              sendMessage();
            },
            icon: const Icon(Icons.send, color: buttonColor),
          ),
        ],
      ),
    );
  }
}
