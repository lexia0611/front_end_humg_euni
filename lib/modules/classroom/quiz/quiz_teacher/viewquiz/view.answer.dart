// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:fe/provider/quiz.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'view.quiz.cubit.dart';
import 'view.quiz.cubit.state.dart';

class ViewAnswer extends StatefulWidget {
  const ViewAnswer({super.key});

  @override
  State<ViewAnswer> createState() => _ViewAnswerState();
}

class _ViewAnswerState extends State<ViewAnswer>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(
        context); // Ensure that the AutomaticKeepAliveClientMixin is correctly implemented.
    return BlocBuilder<ViewQuizCubit, ViewQuizCubitState>(
      builder: (context, state) {
        return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                      border: TableBorder.all(
                        color: Colors.black,
                        //style: BorderStyle.solid,
                        width: 0.1,
                      ),
                      columns: [
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'STT',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Student',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                        for (var i = 0; i < state.listQuestion.length; i++)
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Q ${i + 1}',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Point',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                      rows: [
                        for (int index = 0;
                            index < state.listStudent.length;
                            index++)
                          DataRow(cells: [
                            DataCell(Text(
                              '${index + 1}',
                              style: TextStyle(fontSize: 13),
                            )),
                            DataCell(
                              Text(
                                '${state.listStudent[index].ma_sinh_vien} - ${state.listStudent[index].ho_lot} ${state.listStudent[index].ten}',
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                            for (var i = 0; i < state.listQuestion.length; i++)
                              DataCell(
                                Text(
                                  (state.listAnswer[index] != null &&
                                          state.listAnswer[index]
                                                  ?.answerConvert[i] !=
                                              null)
                                      ? (state.listAnswer[index]
                                                  ?.answerConvert[i] ==
                                              1
                                          ? 'A'
                                          : (state.listAnswer[index]
                                                      ?.answerConvert[i] ==
                                                  2
                                              ? 'B'
                                              : (state.listAnswer[index]
                                                          ?.answerConvert[i] ==
                                                      3
                                                  ? 'C'
                                                  : 'D')))
                                      : '',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            DataCell(state.listAnswer[index] != null
                                ? TextField(
                                    keyboardType: TextInputType.number,
                                    controller: TextEditingController(
                                        text:
                                            "${state.listAnswer[index]!.point ?? ""}"),
                                    onChanged: (value) async {
                                      var point = int.tryParse(value);
                                      if (point != null) {
                                        var answerModel =
                                            state.listAnswer[index];
                                        if (answerModel != null) {
                                          answerModel.point = point;
                                          await QuizProvider.updateAnswer(
                                              quizAnserModel: answerModel);
                                        }
                                      }
                                    },
                                  )
                                : Text(
                                    '',
                                    style: TextStyle(fontSize: 13),
                                  )),
                          ])
                      ]),
                ),
              ],
            ));
      },
    );
  }
}
