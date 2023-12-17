import 'package:fe/app/widgets/view.image.dart';
import 'package:fe/model/message.model.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:fe/provider/file.provider.dart';

class MessageImage extends StatelessWidget {
  final MessageModel message;
  final bool isAnother;
  const MessageImage(
      {super.key, required this.message, required this.isAnother});

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
        onLongPress: () {
          showPopover(
            radius: 10,
            context: context,
            bodyBuilder: (context) => ListItems(
              handleCopy: (value) {
                if (value != null && value == true) {
                  copyFile(context, message.fileName ?? "");
                }
              },
              message: message,
            ),
            onPop: () {},
            direction: PopoverDirection.bottom,
            width: 200,
            // height: message.type == "text" ? 135 : 65,
            // height: 300,
            arrowHeight: 15,
            arrowWidth: 30,
          );
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: isAnother
                  ? Colors.white
                  : const Color.fromARGB(255, 255, 241, 246),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment:
                isAnother ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              isAnother
                  ? Text(
                      "${message.createUserName}",
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 5),
              Image.network(
                message.linkFile ?? "",
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}

class ListItems extends StatelessWidget {
  final Function handleCopy;
  final MessageModel message;
  const ListItems({Key? key, required this.message, required this.handleCopy})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(10),
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
              handleCopy(true);
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: const Center(
                  child: Text('Copy Link',
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w500))),
            ),
          ),
        ],
      ),
    );
  }
}
