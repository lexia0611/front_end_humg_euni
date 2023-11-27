// ignore_for_file: use_build_context_synchronously

import 'package:fe/model/group.model.dart';
import 'package:fe/provider/group.provider.dart';
import 'package:flutter/material.dart';

class DeleteGroup extends StatelessWidget {
  final GroupModel groupModel;
  const DeleteGroup({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Xác nhận xoá nhóm", style: TextStyle(fontSize: 20)),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Text("Xoá nhóm: ${groupModel.name ?? ""}"),
      ),
      actions: [
        Container(
          width: 70,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Center(
              child: Text(
                "Huỷ",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ),
        Container(
          width: 70,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            onTap: () async {
              await GroupProvider.deleteGroup(groupModel.id ?? 0);
              Navigator.pop(context, true);
            },
            child: const Center(
              child: Text(
                "Xoá",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}
