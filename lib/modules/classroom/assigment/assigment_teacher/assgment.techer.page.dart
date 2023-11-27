// ignore_for_file: use_build_context_synchronously

import 'package:animation_list/animation_list.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fe/app/widgets/button.not.click.multi.dart';
import 'package:fe/model/assigment.model.dart';
import 'package:fe/model/class.model.dart';
import 'package:fe/modules/classroom/assigment/assigment_teacher/view_assigment/view.assigment.cubit.dart';
import 'package:fe/modules/classroom/assigment/assigment_teacher/view_assigment/view.assigment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'assgment.techer.cubit.dart';
import 'assgment.techer.cubit.state.dart';
import 'handle/create.assigment.dart';
import 'handle/delete.group.dart';
import 'handle/update.assigment.dart';

class AssigmentTeacherPage extends StatefulWidget {
  final ClassModel classModel;
  const AssigmentTeacherPage({super.key, required this.classModel});

  @override
  State<AssigmentTeacherPage> createState() => _AssigmentTeacherPageState();
}

class _AssigmentTeacherPageState extends State<AssigmentTeacherPage> {
  Map<int, String> listStatus = {
    -1: 'All',
    0: 'Done',
    1: 'Active',
  };
  int? statusQuiz = -1;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssigmentTeacherCubit, AssigmentTeacherCubitState>(
      builder: (context, state) {
        if (state.status == AssigmentStatus.loading) {
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
                                context.read<AssigmentTeacherCubit>().getListAssigmentTeacher();
                              } else {
                                context.read<AssigmentTeacherCubit>().getListAssigmentTeacher(status: statusQuiz);
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
                  children: state.listAssigment
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
                                        create: (context) => ViewAssigmentCubit(
                                          assigmentModel: element,
                                          classModel: widget.classModel,
                                        ),
                                      ),
                                    ], child: const ViewAssigmentPage()),
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
                                                  "Create: ${DateFormat("HH:mm dd/MM/yyyy").format(DateTime.parse(element.createTime ?? "").toLocal())}",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  "Dueday: ${DateFormat("HH:mm dd/MM/yyyy").format(DateTime.parse(element.dueDay ?? "").toLocal())}",
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
                                                        return UpdateAssigment(assigmentModel: element);
                                                      });
                                                  if (response != null && response.runtimeType == AssigmentModel) {
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
                                                        return DeleteAssigment(assigmentModel: element);
                                                      });
                                                  if (response != null && response == true) {
                                                    context.read<AssigmentTeacherCubit>().getListAssigmentTeacher();
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
                            return CreateAssigment(classModel: widget.classModel);
                          });
                      if (response != null && response == true) {
                        context.read<AssigmentTeacherCubit>().getListAssigmentTeacher();
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
