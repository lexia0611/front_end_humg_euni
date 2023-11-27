// ignore_for_file: use_build_context_synchronously

import 'package:fe/model/message.model.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

import 'info.message.dart';

class OwnMessage extends StatelessWidget {
  final bloc;
  final int index;
  final MessageModel message;
  final bool isShowTime;
  const OwnMessage(this.index, this.message, {super.key, required this.isShowTime, required this.bloc});

  @override
  Widget build(BuildContext contextCurrent) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(child: SizedBox.shrink()),
        InkWell(
          onLongPress: () {
            showPopover(
              radius: 10,
              context: contextCurrent,
              bodyBuilder: (context) => ListItems(
                handleEdit: (value) async {
                  if (value != null && value == true) {
                    TextEditingController textEditingController = TextEditingController(text: message.message ?? "");
                    var text = await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: TextField(
                            controller: textEditingController,
                          ),
                          actions: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle: Theme.of(context).textTheme.labelLarge,
                              ),
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle: Theme.of(context).textTheme.labelLarge,
                              ),
                              child: const Text('Send'),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                            ),
                          ],
                        );
                      },
                    );
                    if (text == true) {
                      bloc.edit(index, textEditingController.text, message);
                    }
                    // print(object)
                  }
                },
                handleDelete: (value) {
                  if (value != null && value == true) {
                    bloc.delete(message);
                  }
                },
                message: message,
              ),
              onPop: () {},
              direction: PopoverDirection.bottom,
              width: 200,
              height: message.type == "text" ? 135 : 65,
              arrowHeight: 15,
              arrowWidth: 30,
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: InfoMessage(message),
          ),
        ),
        // ClipOval(child: SizedBox(width: 46, height: 46, child: AvarNormal(avar: message.createUserImage ?? ''))),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}

class ListItems extends StatelessWidget {
  final Function handleEdit;
  final Function handleDelete;
  final MessageModel message;
  const ListItems({Key? key, required this.message, required this.handleDelete, required this.handleEdit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          if (message.type == "text")
            InkWell(
              onTap: () {
                Navigator.pop(context);
                handleEdit(true);
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                child: const Center(child: Text('Edit', style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w500))),
              ),
            ),
          if (message.type == "text") const Divider(),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              handleDelete(true);
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
              child: const Center(child: Text('Delete', style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w500))),
            ),
          ),
        ],
      ),
    );
  }
}
