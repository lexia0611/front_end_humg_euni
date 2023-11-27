import 'package:fe/app/widgets/view.image.dart';
import 'package:fe/model/message.model.dart';
import 'package:flutter/material.dart';

import 'info.message.dart';

class MessageImage extends StatelessWidget {
  final MessageModel message;
  final bool isAnother;
  const MessageImage({super.key, required this.message, required this.isAnother});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 165),
      child: InkWell(
        onTap: () {
          //
          Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => ViewImageScreen(
                url: message.linkFile ?? "",
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: isAnother ? Colors.white : const Color.fromARGB(255, 255, 241, 246), borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: isAnother ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              isAnother
                  ? Text(
                      "${message.createUserName}",
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 5),
              Image.network(
                message.linkFile ?? "",
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    formatDate(message.createTime ?? ""),
                    style: const TextStyle(color: Colors.black, fontSize: 11),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
