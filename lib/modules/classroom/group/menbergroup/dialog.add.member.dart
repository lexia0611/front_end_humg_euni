// ignore_for_file: use_build_context_synchronously

import 'package:fe/model/sinh.vien.model.dart';
import 'package:flutter/material.dart';

import 'member.group.page.dart';

class DialogAddMember extends StatefulWidget {
  final List<StudentModel> listStudentClass;

  const DialogAddMember({super.key, required this.listStudentClass});

  @override
  State<DialogAddMember> createState() => _DialogAddMemberState();
}

class _DialogAddMemberState extends State<DialogAddMember> {
  late List<bool> selected;
  List<StudentModel> listStudentClassNew = [];
  List<StudentModel> listStudentSelected = [];

  @override
  void initState() {
    super.initState();
    selected = List<bool>.generate(widget.listStudentClass.length, (int index) => false);
    listStudentClassNew = List<StudentModel>.generate(widget.listStudentClass.length, (int index) => widget.listStudentClass[index]);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("List student in class", style: TextStyle(fontSize: 20)),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.66666,
        child: SingleChildScrollView(
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Text('Student'),
              ),
            ],
            rows: List<DataRow>.generate(
              widget.listStudentClass.length,
              (int index) => DataRow(
                color: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                  }
                  if (index.isEven) {
                    return Colors.grey.withOpacity(0.3);
                  }
                  return null;
                }),
                cells: <DataCell>[
                  DataCell(
                    Text(
                      '${widget.listStudentClass[index].ma_sinh_vien} - ${widget.listStudentClass[index].ho_lot} ${widget.listStudentClass[index].ten}',
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
                ],
                selected: selected[index],
                onSelectChanged: (bool? value) {
                  setState(() {
                    selected[index] = value!;
                  });
                  if (selected[index]) {
                    listStudentSelected.add(widget.listStudentClass[index]);
                    listStudentClassNew.remove(widget.listStudentClass[index]);
                  } else {
                    listStudentSelected.remove(widget.listStudentClass[index]);
                    listStudentClassNew.add(widget.listStudentClass[index]);
                  }
                },
              ),
            ),
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
              CallBackData callBackData = CallBackData(listStudentAdd: listStudentSelected, listStudentClassNew: listStudentClassNew);
              Navigator.pop(context, callBackData);
            },
            child: const Center(
              child: Text(
                "Add",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}
