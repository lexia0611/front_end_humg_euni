import 'package:fe/model/message.model.dart';
import 'package:fe/provider/file.provider.dart';
import 'package:flutter/material.dart';

import 'info.message.dart';

class MessageFile extends StatelessWidget {
  final MessageModel message;
  final bool isAnother;
  const MessageFile({super.key, required this.message, required this.isAnother});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 165),
      child: InkWell(
        onTap: () {
          downloadFile(context, message.fileName ?? "");
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width / 2,
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
              Row(
                children: [
                  const Icon(Icons.attach_file),
                  Expanded(
                      child: Text(
                    message.fileName ?? "File",
                    overflow: TextOverflow.ellipsis,
                  )),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    formatDate(message.createTime ?? ""),
                    overflow: TextOverflow.ellipsis,
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
