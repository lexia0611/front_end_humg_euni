// ignore_for_file: prefer_const_constructors

import 'package:fe/model/message.model.dart';
import 'package:flutter/material.dart';

class MessageMess extends StatelessWidget {
  final MessageModel message;
  final bool isAnother;
  const MessageMess(this.message, this.isAnother, {super.key});

  @override
  Widget build(BuildContext context) {
    if (isAnother) {
      return Text(
        message.message ?? '',
        style: TextStyle(height: 1.2, fontSize: 12, fontWeight: FontWeight.w500),
      );
    }
    return Text(
      message.message ?? '',
      style: TextStyle(color: const Color(0xFF363636), height: 1.2, fontSize: 14, fontWeight: FontWeight.w500),
    );
  }
}
