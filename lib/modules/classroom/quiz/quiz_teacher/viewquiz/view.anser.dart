// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:fe/provider/quiz.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'view.quiz.cubit.dart';
import 'view.quiz.cubit.state.dart';

class ViewAnser extends StatefulWidget {
  const ViewAnser({super.key});

  @override
  State<ViewAnser> createState() => _ViewAnserState();
}

class _ViewAnserState extends State<ViewAnser> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Ensure that the AutomaticKeepAliveClientMixin is correctly implemented.
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
                        for (int index = 0; index < state.listStudent.length; index++)
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
                                  (state.listAnser[index] != null && state.listAnser[index]?.anserConvert[i] != null) ? "${state.listAnser[index]?.anserConvert[i] ?? ""}" : '',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            DataCell(state.listAnser[index] != null
                                ? TextField(
                                    keyboardType: TextInputType.number,
                                    controller: TextEditingController(text: "${state.listAnser[index]!.point ?? ""}"),
                                    onChanged: (value) async {
                                      var point = int.tryParse(value);
                                      if (point != null) {
                                        var anserModel = state.listAnser[index];
                                        if (anserModel != null) {
                                          anserModel.point = point;
                                          await QuizProvider.updateAnser(quizAnserModel:anserModel);
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
