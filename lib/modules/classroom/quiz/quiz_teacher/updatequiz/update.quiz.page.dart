// ignore_for_file: prefer_const_constructors

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fe/app/widgets/button.not.click.multi.dart';
import 'package:fe/app/widgets/pick.date.dart';
import 'package:fe/app/widgets/textfield.dart';
import 'package:fe/app/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'update.quiz.cubit.dart';
import 'update.quiz.cubit.state.dart';

class UpdateQuizPage extends StatefulWidget {
  const UpdateQuizPage({super.key});

  @override
  State<UpdateQuizPage> createState() => _UpdateQuizPageState();
}

class _UpdateQuizPageState extends State<UpdateQuizPage> {
  Map<int, String> listStatus = {
    0: 'Done',
    1: 'Active',
  };
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateQuizCubit, UpdateQuizCubitState>(
      listener: (context, state) {
        if (state.status == Status.notNull) {
          showToast(
            context: context,
            msg: "Not null",
            color: Colors.orange,
            icon: const Icon(Icons.warning),
          );
        }
        if (state.status == Status.success) {
          Navigator.pop(context, true);
        }
        if (state.status == Status.successEdit) {
          Navigator.pop(context, state.quizModel);
        }
      },
      builder: (context, state) {
        // if (state.status == Status.loading) {
        //   return const Center(
        //       child: CircularProgressIndicator(
        //     color: Colors.blue,
        //   ));
        // }
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
            title: const Center(
              child: Text(
                "Quiz",
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFieldWidget(
                    title: 'Title',
                    controller: context.read<UpdateQuizCubit>().title,
                    maxLine: 1,
                  ),
                  const SizedBox(height: 15),
                  DatePickerBox1(
                      requestDayAfter: DateFormat("dd-MM-yyyy").format(DateTime.now().toLocal()),
                      isTime: true,
                      label: const Text(
                        'Start time',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      dateDisplay: context.read<UpdateQuizCubit>().datStart,
                      timeDisplay: context.read<UpdateQuizCubit>().timeStart,
                      selectedDateFunction: (day) {
                        if (day == null) {
                          context.read<UpdateQuizCubit>().updateStartTime("");
                        }
                      },
                      selectedTimeFunction: (time) {
                        if (time == null) {
                          context.read<UpdateQuizCubit>().updateStartTime("");
                        }
                      },
                      getFullTime: (time) {
                        context.read<UpdateQuizCubit>().updateStartTime(time ?? "");
                      }),
                  const SizedBox(height: 15),
                  DatePickerBox1(
                      requestDayAfter: DateFormat("dd-MM-yyyy").format(DateTime.now().toLocal()),
                      isTime: true,
                      label: const Text(
                        'End time',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      dateDisplay: context.read<UpdateQuizCubit>().datEnd,
                      timeDisplay: context.read<UpdateQuizCubit>().timeEnd,
                      selectedDateFunction: (day) {
                        if (day == null) {
                          context.read<UpdateQuizCubit>().updateEndTime("");
                        }
                      },
                      selectedTimeFunction: (time) {
                        if (time == null) {
                          context.read<UpdateQuizCubit>().updateEndTime("");
                        }
                      },
                      getFullTime: (time) {
                        context.read<UpdateQuizCubit>().updateEndTime(time ?? "");
                      }),
                  const SizedBox(height: 15),
                  if (state.quizModel.id != null)
                    Column(
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
                              value: state.quizModel.status,
                              onChanged: (value) {
                                setState(() {
                                   context.read<UpdateQuizCubit>().updateStatus(value);
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  const Text(
                    'Question',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 15),
                  for (var i = 0; i < state.listQuestion.length; i++)
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: EdgeInsets.only(top: 5, bottom: 10),
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                  onTap: () {
                                    context.read<UpdateQuizCubit>().removeQuestion(i, state.listQuestion[i]);
                                  },
                                  child: Icon(Icons.remove))
                            ],
                          ),
                          TextFieldWidget(
                            title: 'Question ${i + 1}',
                            maxLine: 1,
                            controller: TextEditingController(text: state.listQuestion[i].question ?? ""),
                            onChanged: (value) {
                              if (mounted) {
                                state.listQuestion[i].question = value;
                                context.read<UpdateQuizCubit>().updateQuestion(state.listQuestion[i], i);
                              }
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFieldWidget(
                            title: 'Option 1',
                            styleTitle: TextStyle(fontSize: 13),
                            maxLine: 1,
                            controller: TextEditingController(text: state.listQuestion[i].option1 ?? ""),
                            onChanged: (value) {
                              state.listQuestion[i].option1 = value;
                              context.read<UpdateQuizCubit>().updateQuestion(state.listQuestion[i], i);
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFieldWidget(
                            title: 'Option 2',
                            styleTitle: TextStyle(fontSize: 13),
                            maxLine: 1,
                            controller: TextEditingController(text: state.listQuestion[i].option2 ?? ""),
                            onChanged: (value) {
                              state.listQuestion[i].option2 = value;
                              context.read<UpdateQuizCubit>().updateQuestion(state.listQuestion[i], i);
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFieldWidget(
                            title: 'Option 3',
                            styleTitle: TextStyle(fontSize: 13),
                            maxLine: 1,
                            controller: TextEditingController(text: state.listQuestion[i].option3 ?? ""),
                            onChanged: (value) {
                              state.listQuestion[i].option3 = value;
                              context.read<UpdateQuizCubit>().updateQuestion(state.listQuestion[i], i);
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFieldWidget(
                            title: 'Option 4',
                            styleTitle: TextStyle(fontSize: 13),
                            maxLine: 1,
                            controller: TextEditingController(text: state.listQuestion[i].option4 ?? ""),
                            onChanged: (value) {
                              state.listQuestion[i].option4 = value;
                              context.read<UpdateQuizCubit>().updateQuestion(state.listQuestion[i], i);
                            },
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 15),
                  DottedBorder(
                    radius: const Radius.circular(15),
                    child: ButtonNotClickMulti(
                      onTap: () {
                        context.read<UpdateQuizCubit>().addQuestion();
                      },
                      child: const SizedBox(
                        height: 30,
                        child: Center(
                          child: Icon(Icons.add),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ButtonNotClickMulti(
                      onTap: () {
                        context.read<UpdateQuizCubit>().send();
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
                      ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
