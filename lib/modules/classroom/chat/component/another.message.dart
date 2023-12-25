import 'package:fe/app/widgets/avar.with.type.contact.dart';
import 'package:fe/model/message.model.dart';
import 'package:flutter/material.dart';
import 'info.message.dart';

class AnotherMessage extends StatelessWidget {
  final MessageModel message;
  final bool isShowAvatar;
  final bool isShowTime;
  const AnotherMessage(this.message, {super.key, required this.isShowAvatar, required this.isShowTime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (isShowAvatar) Positioned(left: 0, top: 10, child: SizedBox(width: 46, height: 46, child: AvatarNormal(avar: message.createUserImage ?? ''))),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                width: 44,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 10),
                child: InfoMessage(
                  message,
                  isAnother: true,
                ),
              ),
              const Expanded(child: SizedBox.shrink()),
            ],
          ),
        ],
      ),
    );
  }
}

