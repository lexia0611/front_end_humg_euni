// ignore_for_file: prefer_const_constructors
import 'package:fe/app/widgets/button.not.click.multi.dart';
import 'package:fe/app/widgets/toast.dart';
import 'package:fe/modules/classroom/quiz/quiz_student/answer_quiz/answer.quiz.cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'answer.quiz.cubit.state.dart';

class AnswerQuizPage extends StatelessWidget {
  const AnswerQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnswerQuizCubit, AnswerQuizCubitState>(
      listener: (context, state) {
        if (state.status == Status.success) {
          showToast(
            context: context,
            msg: "Success",
            color: const Color.fromARGB(255, 112, 255, 117),
            icon: const Icon(Icons.done),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                size: 30,
                color: Colors.white,
              ),
            ),
            title: Column(
              children: [
                Text(
                  state.quizModel.title ?? "",
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Start: ${DateFormat("HH:mm dd/MM/yyyy").format(DateTime.parse(state.quizModel.startTime ?? "").toLocal())}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "End: ${DateFormat("HH:mm dd/MM/yyyy").format(DateTime.parse(state.quizModel.endTime ?? "").toLocal())}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < state.listQuestion.length; i++)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Question ${i + 1}: ${state.listQuestion[i].question ?? ""}",
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        ListTile(
                          title: Text('${state.listQuestion[i].option1}'),
                          leading: Radio<int>(
                            value: 1,
                            groupValue: state.listAnswer[i],
                            onChanged: (int? value) {
                              if (state.quizModel.quizAnswerModel == null) context.read<AnswerQuizCubit>().updateAnswer(i, value);
                            },
                          ),
                        ),
                        ListTile(
                          title: Text('${state.listQuestion[i].option2}'),
                          leading: Radio<int>(
                            value: 2,
                            groupValue: state.listAnswer[i],
                            onChanged: (int? value) {
                              if (state.quizModel.quizAnswerModel == null) context.read<AnswerQuizCubit>().updateAnswer(i, value);
                            },
                          ),
                        ),
                        ListTile(
                          title: Text('${state.listQuestion[i].option3}'),
                          leading: Radio<int>(
                            value: 3,
                            groupValue: state.listAnswer[i],
                            onChanged: (int? value) {
                              if (state.quizModel.quizAnswerModel == null) context.read<AnswerQuizCubit>().updateAnswer(i, value);
                            },
                          ),
                        ),
                        ListTile(
                          title: Text('${state.listQuestion[i].option4}'),
                          leading: Radio<int>(
                            value: 4,
                            groupValue: state.listAnswer[i],
                            onChanged: (int? value) {
                              if (state.quizModel.quizAnswerModel == null) context.read<AnswerQuizCubit>().updateAnswer(i, value);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  (state.quizModel.quizAnswerModel == null)
                      ? Center(
                          child: ButtonNotClickMulti(
                              onTap: () {
                                bool check = true;
                                for (var i = 0; i < state.listAnswer.length; i++) {
                                  if (state.listAnswer[i] == null) {
                                    showToast(
                                      context: context,
                                      msg: "Haven't answered question ${i + 1} yet",
                                      color: Colors.orange,
                                      icon: const Icon(Icons.warning),
                                    );
                                    check = false;
                                    break;
                                  }
                                }
                                if (check) {
                                  context.read<AnswerQuizCubit>().sendAnswer();
                                }
                              },
                              child: Container(
                                width: 100,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                      offset: const Offset(2, 2), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: const Center(
                                  child: Text(
                                    "Send",
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              )),
                        )
                      : SizedBox.shrink()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
