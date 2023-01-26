import 'dart:async';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:converse_gpt/api_keys.dart';
import 'package:converse_gpt/constants.dart';
import 'package:converse_gpt/views/widgets/chat_message.dart';
import 'package:converse_gpt/views/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  ChatGPT? chatGpt;
  StreamSubscription? _subscription;

  void _sendMessage() {
    ChatMessage botMessage;
    ChatMessage chatMessage = ChatMessage(
      text: _textController.text,
      sender: "You",
    );
    setState(() {
      _messages.insert(0, chatMessage);
    });

    final request = CompleteReq(
        prompt: _textController.text,
        model: kTranslateModelV3,
        max_tokens: 1000);

    _subscription = chatGpt!
        .builder(OPEN_AI_API_KEY,
            baseOption: HttpSetup(
              receiveTimeout: 6000,
            ))
        .onCompleteStream(request: request)
        .listen((response) {
      print(response!.choices[0].text);
      // Bot Response
      botMessage = ChatMessage(
        text: response.choices[0].text,
        sender: "Bot",
      );

      setState(() {
        _messages.insert(0, botMessage);
      });
    });

    _textController.clear();
  }

  @override
  void initState() {
    super.initState();
    chatGpt = ChatGPT.instance;
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Converse GPT",
          style: TextStyle(
            color: textColor,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                reverse: true,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _messages[index],
                  );
                },
              ),
            ),
            Divider(thickness: 1),
            CustomTextField(
              textController: _textController,
              sendMessage: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
