// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:animation_list/animation_list.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fe/app/widgets/button.not.click.multi.dart';
import 'package:fe/model/class.model.dart';
import 'package:fe/model/quiz.model.dart';
import 'package:fe/modules/classroom/quiz/quiz_teacher/updatequiz/update.quiz.cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'quiz.teacher.cubit.dart';
import 'quiz.teacher.cubit.state.dart';
import 'updatequiz/delete.group.dart';
import 'updatequiz/update.quiz.page.dart';
import 'viewquiz/view.quiz.cubit.dart';
import 'viewquiz/view.quiz.page.dart';

class QuizTeacherPage extends StatefulWidget {
  final ClassModel classModel;
  const QuizTeacherPage({super.key, required this.classModel});

  @override
  State<QuizTeacherPage> createState() => _QuizTeacherPageState();
}

class _QuizTeacherPageState extends State<QuizTeacherPage> {
  Map<int, String> listStatus = {
    -1: 'All',
    0: 'Done',
    1: 'Active',
  };
  int? statusQuiz = -1;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizTeacherCubit, QuizTeacherCubitState>(
      builder: (context, state) {
        if (state.status == AssignmentStatus.loading) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.blue,
          ));
        }
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                                context.read<QuizTeacherCubit>().getListQuizTeacher();
                              } else {
                                context.read<QuizTeacherCubit>().getListQuizTeacher(status: statusQuiz);
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
                  children: state.listQuizModel
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
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => MultiBlocProvider(
                                        providers: [
                                          BlocProvider(
                                            create: (context) => ViewQuizCubit(
                                              quizModel: element,
                                            ),
                                          ),
                                        ],
                                        child: ViewQuizPage(
                                          quizModel: element,
                                        )),
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
                                                  "Start: ${DateFormat("HH:mm dd/MM/yyyy").format(DateTime.parse(element.startTime ?? "").toLocal())}",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  "End: ${DateFormat("HH:mm dd/MM/yyyy").format(DateTime.parse(element.endTime ?? "").toLocal())}",
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
                                                  var response = await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (BuildContext context) => MultiBlocProvider(providers: [
                                                        BlocProvider(
                                                          create: (context) => UpdateQuizCubit(classModel: widget.classModel, quizModel: element),
                                                        ),
                                                      ], child: const UpdateQuizPage()),
                                                    ),
                                                  );
                                                  if (response != null && response.runtimeType == QuizModel) {
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
                                                        return DeleteQuiz(quizModel: element);
                                                      });
                                                  if (response != null && response == true) {
                                                    context.read<QuizTeacherCubit>().getListQuizTeacher();
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
                      var response = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => MultiBlocProvider(providers: [
                            BlocProvider(
                              create: (context) => UpdateQuizCubit(classModel: widget.classModel),
                            ),
                          ], child: const UpdateQuizPage()),
                        ),
                      );
                      if (response != null && response == true) {
                        context.read<QuizTeacherCubit>().getListQuizTeacher();
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
