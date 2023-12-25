// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:fe/app/widgets/pick.date.dart';
import 'package:fe/app/widgets/textfield.dart';
import 'package:fe/model/assignment.model.dart';
import 'package:fe/model/class.model.dart';
import 'package:fe/provider/assignment.provider.dart';
import 'package:fe/provider/file.provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateAssignment extends StatefulWidget {
  final ClassModel classModel;
  const CreateAssignment({super.key, required this.classModel});

  @override
  State<CreateAssignment> createState() => _CreateAssignmentState();
}

class _CreateAssignmentState extends State<CreateAssignment> {
  AssignmentModel assignmentModel = AssignmentModel(status: 1);
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  var date1;
  var time1;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Create assignment", style: TextStyle(fontSize: 20)),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 330,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFieldWidget(
                title: 'Title',
                controller: name,
                maxLine: 1,
              ),
              const SizedBox(height: 15),
              TextFieldWidget(
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
                                (assignmentModel.fileName != null) ? "File uploaded" : "Upload file",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: 10),
                            InkWell(
                                onTap: () async {
                                  var fileName = await handleUploadFileAll();
                                  setState(() {
                                    assignmentModel.fileName = fileName;
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
                      assignmentModel.dueDay = null;
                    }
                  },
                  selectedTimeFunction: (time) {
                    if (time == null) {
                      assignmentModel.dueDay = null;
                    }
                  },
                  getFullTime: (time) {
                    if (time != "") {
                      assignmentModel.dueDay = time;
                    } else {
                      assignmentModel.dueDay = null;
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
              if (name.text != "" && assignmentModel.dueDay != null) {
                assignmentModel.classId = widget.classModel.id ??"";
                assignmentModel.title = name.text;
                assignmentModel.description = description.text;
                await AssignmentProvider.create(assignmentModel);
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
