// ignore_for_file: use_build_context_synchronously

import 'package:animation_list/animation_list.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fe/app/widgets/button.not.click.multi.dart';
import 'package:fe/modules/classroom/assignment/assignment_student/assignment.student.cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'assignment.student.cubit.state.dart';
import 'view_assignment/view.assignment.student.cubit.dart';
import 'view_assignment/view.assignment.student.page.dart';

class AssignmentStudentPage extends StatefulWidget {
  const AssignmentStudentPage({super.key});

  @override
  State<AssignmentStudentPage> createState() => _AssignmentStudentPageState();
}

class _AssignmentStudentPageState extends State<AssignmentStudentPage> {
  Map<int, String> listStatus = {
    -1: 'All',
    0: 'Done',
    1: 'Active',
  };
  int? statusQuiz = -1;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssignmentStudentCubit, AssignmentStudentCubitState>(
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
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 2, color: Colors.grey)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          items: listStatus.entries.map((item) => DropdownMenuItem<int>(value: item.key, child: Text(item.value))).toList(),
                          value: statusQuiz,
                          onChanged: (value) {
                            setState(() {
                              statusQuiz = value ?? -1;
                              // if()
                              if (statusQuiz == -1) {
                                context.read<AssignmentStudentCubit>().getListAssignmentTeacher();
                              } else {
                                context.read<AssignmentStudentCubit>().getListAssignmentTeacher(status: statusQuiz);
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
                              color: element.status == 1
                                  ? (DateTime.now().difference(DateTime.parse(element.dueDay ?? "").toLocal()).inMilliseconds > 0)
                                      ? const Color.fromARGB(255, 255, 204, 201)
                                      : (element.assignmentStudentModel?.fileName != null)
                                          ? const Color.fromARGB(255, 222, 240, 255)
                                          : const Color.fromARGB(255, 255, 239, 214)
                                  : Colors.white,
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
                                        create: (context) => ViewAssignmentStudentCubit(
                                          assignmentModel: element,
                                        ),
                                      ),
                                    ], child: const ViewAssignmentStudentPage()),
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
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
