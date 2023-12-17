// ignore_for_file: use_build_context_synchronously

import 'package:fe/model/assignment.model.dart';
import 'package:fe/provider/assignment.provider.dart';
import 'package:flutter/material.dart';

class DeleteAssigment extends StatelessWidget {
  final AssignmentModel assigmentModel;
  const DeleteAssigment({super.key, required this.assigmentModel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Comfirm delete", style: TextStyle(fontSize: 20)),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Text("Delete: ${assigmentModel.title ?? ""}"),
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
                "Cancel",
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
              await AssignmentProvider.delete(assigmentModel.id ?? 0);
              Navigator.pop(context, true);
            },
            child: const Center(
              child: Text(
                "Delete",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}
