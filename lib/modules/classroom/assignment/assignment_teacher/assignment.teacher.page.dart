import 'package:animation_list/animation_list.dart';
import 'package:fe/app/widgets/button.not.click.multi.dart';
import 'package:fe/model/assignment.model.dart';
import 'package:fe/model/class.model.dart';
import 'package:fe/modules/classroom/assignment/assignment_teacher/view_assignment/view.assignment.cubit.dart';
import 'package:fe/modules/classroom/assignment/assignment_teacher/view_assignment/view.assignment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'assignment.teacher.cubit.dart';
import 'assignment.teacher.cubit.state.dart';
import 'handle/create.assignment.dart';
import 'handle/delete.group.dart';
import 'handle/update.assignment.dart';

class AssignmentTeacherPage extends StatefulWidget {
  final ClassModel classModel;
  const AssignmentTeacherPage({super.key, required this.classModel});

  @override
  State<AssignmentTeacherPage> createState() => _AssignmentTeacherPageState();
}

class _AssignmentTeacherPageState extends State<AssignmentTeacherPage> {
  Map<int, String> listStatus = {
    -1: 'All',
    0: 'Done',
    1: 'Active',
  };
  int? statusQuiz = -1;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssignmentTeacherCubit, AssignmentTeacherCubitState>(
      builder: (context, state) {
        if (state.status == AssignmentStatus.loading) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.blue,
          ));
        }
        return Scaffold(
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Status",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 2, color: Colors.grey)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          items: listStatus.entries.map((item) => DropdownMenuItem<int>(value: item.key, child: Text(item.value))).toList(),
                          value: statusQuiz,
                          onChanged: (value) {
                            setState(() {
                              statusQuiz = value ?? -1;
                              // if()
                              if (statusQuiz == -1) {
                                context.read<AssignmentTeacherCubit>().getListAssignmentTeacher();
                              } else {
                                context.read<AssignmentTeacherCubit>().getListAssignmentTeacher(status: statusQuiz);
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: AnimationList(
                  children: state.listAssignment
                      .map((element) => Container(
                            margin: const EdgeInsets.all(15),
                            padding: const EdgeInsets.all(15),
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
                                  spreadRadius: 5,
                                  blurRadius: 8,
                                  offset: const Offset(3, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ButtonNotClickMulti(
                              onTap: () async {
                                // SharedPreferences prefs = await SharedPreferences.getInstance();
                                // String? idUSer = prefs.getString("id");
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => MultiBlocProvider(providers: [
                                      BlocProvider(
                                        create: (context) => ViewAssignmentCubit(
                                          assignmentModel: element,
                                          classModel: widget.classModel,
                                        ),
                                      ),
                                    ], child: const ViewAssignmentPage()),
                                  ),
                                );
                                // if (response != null) {
                                //   setState(() {
                                //     listGroup[index] = response;
                                //   });
                                // }
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          element.title ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          "Status: ${element.status == 1 ? "Active" : "Done"}",
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                                        ),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Created: ${DateFormat("HH:mm dd/MM/yyyy").format(DateTime.parse(element.createTime ?? "").toLocal())}",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  "Expired: ${DateFormat("HH:mm dd/MM/yyyy").format(DateTime.parse(element.dueDay ?? "").toLocal())}",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  (state.isGV)
                                      ? Column(
                                          children: [
                                            Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: InkWell(
                                                onTap: () async {
                                                  var response = await showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return UpdateAssignment(assignmentModel: element);
                                                      });
                                                  if (response != null && response.runtimeType == AssignmentModel) {
                                                    setState(() {
                                                      element = response;
                                                    });
                                                  }
                                                },
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.edit,
                                                    color: Colors.white,
                                                    size: 15,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: InkWell(
                                                onTap: () async {
                                                  var response = await showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return DeleteAssignment(assignmentModel: element);
                                                      });
                                                  if (response != null && response == true) {
                                                    context.read<AssignmentTeacherCubit>().getListAssignmentTeacher();
                                                  }
                                                },
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                    size: 15,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      : const SizedBox.shrink()
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
          floatingActionButton: (state.isGV)
              ? Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.blue),
                  child: InkWell(
                    onTap: () async {
                      var response = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CreateAssignment(classModel: widget.classModel);
                          });
                      if (response != null && response == true) {
                        context.read<AssignmentTeacherCubit>().getListAssignmentTeacher();
                      }
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                )
              : null,
        );
      },
    );
  }
}
