// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:fe/app/widgets/pick.date.dart';
import 'package:fe/app/widgets/textfiel.dart';
import 'package:fe/model/assigment.model.dart';
import 'package:fe/model/class.model.dart';
import 'package:fe/provider/assigment.provider.dart';
import 'package:fe/provider/file.provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateAssigment extends StatefulWidget {
  final ClassModel classModel;
  const CreateAssigment({super.key, required this.classModel});

  @override
  State<CreateAssigment> createState() => _CreateAssigmentState();
}

class _CreateAssigmentState extends State<CreateAssigment> {
  AssigmentModel assigmentModel = AssigmentModel(status: 1);
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  var date1;
  var time1;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Create asigment", style: TextStyle(fontSize: 20)),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 330,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFielWidget(
                title: 'Title',
                controller: name,
                maxLine: 1,
              ),
              const SizedBox(height: 15),
              TextFielWidget(
                title: 'Description',
                controller: description,
              ),
              const SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Attachment Url",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        height: 50,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 2, color: Colors.grey)),
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                (assigmentModel.fileName != null) ? "File uploaded" : "Upload file",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: 10),
                            InkWell(
                                onTap: () async {
                                  var fileName = await handleUploadFileAll();
                                  setState(() {
                                    assigmentModel.fileName = fileName;
                                  });
                                },
                                child: Icon(
                                  Icons.upload,
                                  color: Colors.blue,
                                )),
                            SizedBox(width: 10),
                          ],
                        ),
                      ))
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              DatePickerBox1(
                  requestDayAfter: DateFormat("dd-MM-yyyy").format(DateTime.now().toLocal()),
                  isTime: true,
                  label: Text(
                    'Due Day:',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  dateDisplay: date1,
                  timeDisplay: time1,
                  selectedDateFunction: (day) {
                    if (day == null) {
                      assigmentModel.dueDay = null;
                    }
                  },
                  selectedTimeFunction: (time) {
                    if (time == null) {
                      assigmentModel.dueDay = null;
                    }
                  },
                  getFullTime: (time) {
                    if (time != "") {
                      assigmentModel.dueDay = time;
                    } else {
                      assigmentModel.dueDay = null;
                    }
                  }),
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
              if (name.text != "" && assigmentModel.dueDay != null) {
                assigmentModel.classId = widget.classModel.id ??"";
                assigmentModel.title = name.text;
                assigmentModel.description = description.text;
                await AssigmentProvider.create(assigmentModel);
                Navigator.pop(context, true);
              }
            },
            child: const Center(
              child: Text(
                "Save",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}
