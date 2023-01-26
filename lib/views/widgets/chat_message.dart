import 'package:converse_gpt/constants.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  ChatMessage({
    required this.text,
    required this.sender,
    Key? key,
  }) : super(key: key);

  String text;
  String sender;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 15),
          // child: CircleAvatar(
          //   backgroundColor: (sender == "User") ? buttonColor : redColor,
          //   child: Text(
          //     sender,
          //     style: const TextStyle(
          //       color: textColor,
          //       fontSize: 18,
          //       fontWeight: FontWeight.w600,
          //     ),
          //   ),
          // ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0), //or 15.0
            child: Container(
              height: 45.0,
              width: 50.0,
              color: (sender == "User") ? buttonColor : redColor,
              child: Center(
                child: Text(
                  sender,
                  style: const TextStyle(
                    color: backgroundColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 18,
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }
}
