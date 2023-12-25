// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:fe/app/widgets/pick.date.dart';
import 'package:fe/app/widgets/textfield.dart';
import 'package:fe/model/assignment.model.dart';
import 'package:fe/provider/assignment.provider.dart';
import 'package:fe/provider/file.provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class UpdateAssignment extends StatefulWidget {
  final AssignmentModel assignmentModel;
  const UpdateAssignment({super.key, required this.assignmentModel});

  @override
  State<UpdateAssignment> createState() => _UpdateAssignmentState();
}

class _UpdateAssignmentState extends State<UpdateAssignment> {
  AssignmentModel assignmentModel = AssignmentModel(status: 1);
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  var date1;
  var time1;
  Map<int, String> listStatus = {
    0: 'Done',
    1: 'Active',
  };
  @override
  void initState() {
    super.initState();
    assignmentModel = widget.assignmentModel;
    name.text = assignmentModel.title ?? "";
    description.text = assignmentModel.description ?? "";
    date1 = DateFormat('dd-MM-yyyy').format(DateTime.parse(assignmentModel.dueDay ?? ""));
    time1 = DateFormat('HH:mm').format(DateTime.parse(assignmentModel.dueDay ?? ""));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Update assignment", style: TextStyle(fontSize: 20)),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 420,
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
              SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Status",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 2, color: Colors.grey)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        items: listStatus.entries.map((item) => DropdownMenuItem<int>(value: item.key, child: Text(item.value))).toList(),
                        value: assignmentModel.status,
                        onChanged: (value) {
                          setState(() {
                            assignmentModel.status = value as int;
                          });
                        },
                      ),
                    ),
                  ),
                ],
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
                assignmentModel.title = name.text;
                assignmentModel.description = description.text;
                await AssignmentProvider.update(assignmentModel);
                Navigator.pop(context, assignmentModel);
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
