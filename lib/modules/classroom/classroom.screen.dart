import 'package:fe/model/class.model.dart';
import 'package:fe/modules/classroom/assignment/assignment_student/assignment.student.cubit.dart';
import 'package:fe/modules/classroom/assignment/assignment_student/assignment.student.page.dart';
import 'package:fe/modules/classroom/assignment/assignment_teacher/assignment.teacher.cubit.dart';
import 'package:fe/modules/classroom/chat/chat.cubit.dart';
import 'package:fe/modules/classroom/chat/chat.page.dart';
import 'package:fe/modules/classroom/quiz/quiz_student/quiz.student.cubit.dart';
import 'package:fe/modules/classroom/quiz/quiz_student/quiz.student.page.dart';
import 'package:fe/modules/classroom/quiz/quiz_teacher/quiz.teacher.cubit.dart';
import 'package:fe/modules/classroom/quiz/quiz_teacher/quiz.teacher.page.dart';
import 'package:fe/modules/classroom/vote/vote.cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'assignment/assignment_teacher/assignment.teacher.page.dart';
import 'chat/list.chat.cubit.dart';
import 'group/group.cubit.dart';
import 'group/group.page.dart';
import 'list_sinhvien/list.sinh.vien.screen.dart';
import 'vote/vote.page.dart';

class ClassRoomScreen extends StatefulWidget {
  final ClassModel classModel;
  final String idUser;
  final bool isTeacher;
  const ClassRoomScreen({super.key, required this.classModel, required this.idUser, required this.isTeacher});

  @override
  State<ClassRoomScreen> createState() => _ClassRoomScreenState();
}

class _ClassRoomScreenState extends State<ClassRoomScreen> {
  getUser() async {}

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
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
        title: Center(
          child: Text(
            widget.classModel.tenMon ?? "",
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        actions: [
          InkWell(
            onTap: () async {
              // ListSinhVienScreen
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => ListSinhVienScreen(
                    classModel: widget.classModel,
                  ),
                ),
              );
            },
            child: const Icon(
              Icons.group,
              size: 30,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 10)
        ],
      ),
      body: DefaultTabController(
        length: 5,
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
                          "Chat",
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
                          "Group",
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
                          "Assignment",
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
                          "Quiz",
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
                          "Vote",
                          style: TextStyle(fontSize: 12),
                        )),
                  )
                ],
              ),
              Expanded(
                child: TabBarView(physics: const NeverScrollableScrollPhysics(), children: [
                  MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => ListChatCubit(classModel: widget.classModel),
                        ),
                        BlocProvider(
                          create: (context) => ChatCubit(classModel: widget.classModel),
                        ),
                      ],
                      child: ChatPage(
                        classModel: widget.classModel,
                        idUser: widget.idUser,
                      )),
                  MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => GroupCubit(classModel: widget.classModel),
                        ),
                      ],
                      child: GroupPage(
                        classModel: widget.classModel,
                      )),
                  widget.isTeacher
                      ? MultiBlocProvider(
                          providers: [
                              BlocProvider(
                                create: (context) => AssignmentTeacherCubit(classModel: widget.classModel),
                              ),
                            ],
                          child: AssignmentTeacherPage(
                            classModel: widget.classModel,
                          ))
                      : MultiBlocProvider(providers: [
                          BlocProvider(
                            create: (context) => AssignmentStudentCubit(classModel: widget.classModel),
                          ),
                        ], child: AssignmentStudentPage()),
                  widget.isTeacher
                      ? MultiBlocProvider(
                          providers: [
                              BlocProvider(
                                create: (context) => QuizTeacherCubit(classModel: widget.classModel),
                              ),
                            ],
                          child: QuizTeacherPage(
                            classModel: widget.classModel,
                          ))
                      : MultiBlocProvider(
                          providers: [
                              BlocProvider(
                                create: (context) => QuizStudentCubit(classModel: widget.classModel),
                              ),
                            ],
                          child: QuizStudentPage(
                            classModel: widget.classModel,
                          )),
                  MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => VoteCubit(classModel: widget.classModel),
                        ),
                      ],
                      child: VotePage(
                        classModel: widget.classModel,
                      )),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
