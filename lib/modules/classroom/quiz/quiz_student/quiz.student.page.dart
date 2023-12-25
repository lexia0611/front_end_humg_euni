// ignore_for_file: use_build_context_synchronously

import 'package:animation_list/animation_list.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fe/app/widgets/button.not.click.multi.dart';
import 'package:fe/model/class.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'answer_quiz/answer.quiz.cubit.dart';
import 'answer_quiz/answer.quiz.page.dart';
import 'quiz.student.cubit.dart';
import 'quiz.student.cubit.state.dart';

class QuizStudentPage extends StatefulWidget {
  final ClassModel classModel;
  const QuizStudentPage({super.key, required this.classModel});
  @override
  State<QuizStudentPage> createState() => _QuizStudentPageState();
}

class _QuizStudentPageState extends State<QuizStudentPage> {
  Map<int, String> listStatus = {
    -1: 'All',
    0: 'Done',
    1: 'Active',
  };
  int? statusQuiz = -1;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizStudentCubit, QuizStudentCubitState>(
      builder: (context, state) {
        if (state.status == Status.loading) {
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
                                context.read<QuizStudentCubit>().getListQuizTeacher();
                              } else {
                                context.read<QuizStudentCubit>().getListQuizTeacher(status: statusQuiz);
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
                                    builder: (BuildContext context) => MultiBlocProvider(providers: [
                                      BlocProvider(
                                        create: (context) => AnswerQuizCubit(
                                          quizModel: element,
                                        ),
                                      ),
                                    ], child: const AnswerQuizPage()),
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
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Status: ${element.status == 1 ? "Active" : "Done"}",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  (element.quizAnswerModel?.point != null) ? "Point: ${element.quizAnswerModel?.point}" : "",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                                                ),
                                              ),
                                            ],
                                          ),
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
