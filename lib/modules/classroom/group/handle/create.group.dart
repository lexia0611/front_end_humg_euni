// ignore_for_file: use_build_context_synchronously

import 'package:fe/app/widgets/textfield.dart';
import 'package:fe/model/class.model.dart';
import 'package:fe/model/group.model.dart';
import 'package:fe/provider/file.provider.dart';
import 'package:fe/provider/group.provider.dart';
import 'package:fe/provider/session.provider.dart';
import 'package:flutter/material.dart';

class CreateGroup extends StatefulWidget {
  final ClassModel classModel;
  const CreateGroup({super.key, required this.classModel});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  GroupModel groupModel = GroupModel(avatar: "");
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Thêm mới nhóm", style: TextStyle(fontSize: 20)),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 330,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipOval(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: (groupModel.avatar != null && groupModel.avatar != "")
                      ? Image.network(
                          groupModel.avatar ?? "",
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          "assets/group.png",
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 70,
                height: 30,
                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                child: InkWell(
                  onTap: () async {
                    var fileName = await handleUploadFileAll();
                    if (fileName != null) {
                      setState(() {
                        groupModel.avatar = "$backendURL/api/files/$fileName";
                      });
                    }
                  },
                  child: const Center(
                    child: Text(
                      "Tải ảnh",
                      style: TextStyle(fontSize: 13, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFieldWidget(
                title: 'Tên',
                controller: name,
                maxLine: 1,
              ),
              const SizedBox(height: 15),
              TextFieldWidget(
                title: 'Mô tả',
                controller: description,
                maxLine: 2,
              ),
            ],
          ),
        ),
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
              groupModel.classId = widget.classModel.id ?? "";
              groupModel.name = name.text;
              groupModel.description = description.text;
              groupModel.status = 1;
              await GroupProvider.createGroup(groupModel);
              Navigator.pop(context, true);
            },
            child: const Center(
              child: Text(
                "Thêm",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}
