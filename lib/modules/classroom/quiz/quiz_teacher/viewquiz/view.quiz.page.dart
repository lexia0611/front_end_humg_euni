// ignore_for_file: prefer_const_constructors

import 'package:fe/model/quiz.model.dart';
import 'package:fe/modules/classroom/quiz/quiz_teacher/viewquiz/view.answer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'view.question.dart';
import 'view.quiz.cubit.dart';
import 'view.quiz.cubit.state.dart';

class ViewQuizPage extends StatefulWidget {
  final QuizModel quizModel;
  const ViewQuizPage({super.key, required this.quizModel});

  @override
  State<ViewQuizPage> createState() => _ViewQuizPageState();
}

class _ViewQuizPageState extends State<ViewQuizPage> with SingleTickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ViewQuizCubit, ViewQuizCubitState>(
      listener: (context, state) {},
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
          body: DefaultTabController(
            length: 2,
            child: Container(
              color: Colors.white,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabBar(
                    onTap: (value) {},
                    labelColor: Colors.black,
                    labelStyle: TextStyle(),
                    unselectedLabelStyle: TextStyle(),
                    labelPadding: EdgeInsets.zero,
                    indicatorWeight: 0.1,
                    // indicatorColor: Colors.transparent,
                    tabs: [
                      Tab(
                        icon: Container(
                            height: double.infinity,
                            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Text(
                              "Answer",
                              style: TextStyle(fontSize: 12),
                            )),
                      ),
                      Tab(
                        icon: Container(
                            height: double.infinity,
                            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Text(
                              "Question",
                              style: TextStyle(fontSize: 12),
                            )),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(physics: const NeverScrollableScrollPhysics(), children: const [
                      ViewAnswer(),
                      ViewQuestion(),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
