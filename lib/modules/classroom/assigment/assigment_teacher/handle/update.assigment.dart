// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:fe/app/widgets/pick.date.dart';
import 'package:fe/app/widgets/textfiel.dart';
import 'package:fe/model/assigment.model.dart';
import 'package:fe/provider/assigment.provider.dart';
import 'package:fe/provider/file.provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class UpdateAssigment extends StatefulWidget {
  final AssigmentModel assigmentModel;
  const UpdateAssigment({super.key, required this.assigmentModel});

  @override
  State<UpdateAssigment> createState() => _UpdateAssigmentState();
}

class _UpdateAssigmentState extends State<UpdateAssigment> {
  AssigmentModel assigmentModel = AssigmentModel(status: 1);
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
    assigmentModel = widget.assigmentModel;
    name.text = assigmentModel.title ?? "";
    description.text = assigmentModel.description ?? "";
    date1 = DateFormat('dd-MM-yyyy').format(DateTime.parse(assigmentModel.dueDay ?? ""));
    time1 = DateFormat('HH:mm').format(DateTime.parse(assigmentModel.dueDay ?? ""));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Update asigment", style: TextStyle(fontSize: 20)),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 420,
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
                        value: assigmentModel.status,
                        onChanged: (value) {
                          setState(() {
                            assigmentModel.status = value as int;
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
              if (name.text != "" && assigmentModel.dueDay != null) {
                assigmentModel.title = name.text;
                assigmentModel.description = description.text;
                await AssigmentProvider.update(assigmentModel);
                Navigator.pop(context, assigmentModel);
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
