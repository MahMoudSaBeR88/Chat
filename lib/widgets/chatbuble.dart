import 'package:chat/models/message.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class chatBuble extends StatelessWidget {
  chatBuble({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding:
            const EdgeInsets.only(left: 16, top: 23, bottom: 23, right: 32),
        decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(32),
          ),
        ),
        child: Text(
          message.message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}


class chatBubleForFriends extends StatelessWidget {
  chatBubleForFriends({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding:
        const EdgeInsets.only(left: 16, top: 23, bottom: 23, right: 32),
        decoration: const BoxDecoration(
          color: Color(0xff006D84),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.circular(0),
          ),
        ),
        child: Text(
          message.message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
