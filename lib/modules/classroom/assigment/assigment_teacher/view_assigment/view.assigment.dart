// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:animation_list/animation_list.dart';
import 'package:fe/modules/classroom/assigment/assigment_teacher/evaluate/evaluate.assigment.cubit.dart';
import 'package:fe/modules/classroom/assigment/assigment_teacher/evaluate/evaluate.assigment.dart';
import 'package:fe/provider/file.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'view.assigment.cubit.dart';
import 'view.assigment.cubit.state.dart';

class ViewAssigmentPage extends StatelessWidget {
  const ViewAssigmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewAssigmentCubit, ViewAssigmentCubitState>(
      builder: (context, state) {
        if (state.status == Status.loading) {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.assigmentModel.title ?? "",
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Status: ${state.assigmentModel.status == 1 ? "Active" : "Done"}",
                    style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            body: const Center(
                child: CircularProgressIndicator(
              color: Colors.blue,
            )),
          );
        }
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.assigmentModel.title ?? "",
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Status: ${state.assigmentModel.status == 1 ? "Active" : "Done"}",
                  style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 20),
                    Expanded(child: Text("Create time", style: TextStyle(fontSize: 14, color: const Color.fromARGB(255, 58, 58, 58)))),
                    SizedBox(width: 20),
                    Expanded(
                      flex: 3,
                      child: Text(
                        DateFormat("HH:mm dd/MM/yyyy").format(DateTime.parse(state.assigmentModel.createTime ?? "").toLocal()),
                      ),
                    )
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    SizedBox(width: 20),
                    Expanded(child: Text("Dueday", style: TextStyle(fontSize: 14, color: const Color.fromARGB(255, 58, 58, 58)))),
                    SizedBox(width: 20),
                    Expanded(
                      flex: 3,
                      child: Text(
                        DateFormat("HH:mm dd/MM/yyyy").format(DateTime.parse(state.assigmentModel.dueDay ?? "").toLocal()),
                      ),
                    )
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    SizedBox(width: 20),
                    Expanded(child: Text("Attachment Url", style: TextStyle(fontSize: 14, color: const Color.fromARGB(255, 58, 58, 58)))),
                    SizedBox(width: 20),
                    Expanded(
                      flex: 2,
                      child: state.assigmentModel.fileName != null
                          ? InkWell(
                              onTap: () {
                                downloadFile(context, state.assigmentModel.fileName!);
                              },
                              child: Icon(
                                Icons.download,
                                color: Colors.blue,
                              ))
                          : SizedBox.shrink(),
                    )
                  ],
                ),
                Divider(),
                SizedBox(height: 10),
                Expanded(
                    child: AnimationList(
                  children: state.listAssigmentStudentModel
                      .map((element) => Container(
                            margin: const EdgeInsets.all(15),
                            padding: const EdgeInsets.all(10),
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                  offset: const Offset(3, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${element.username ?? ""} - ${element.student?.ho_lot ?? ""} ${element.student?.ten ?? ""}"),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            element.fileName == null ? 'Homework not submitted' : 'Submitted the assignment',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: element.fileName == null ? Colors.orange : Colors.green,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            element.point == null ? 'Not assessed yet.' : 'Point: ${element.point}',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: element.fileName == null ? Colors.black : Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                                element.fileName != null
                                    ? InkWell(
                                        onTap: () async {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) => MultiBlocProvider(providers: [
                                                BlocProvider(
                                                  create: (context) => EvaluateAssigmentCubit(
                                                    assigmentStudentModel: element,
                                                  ),
                                                ),
                                              ], child: const EvaluateAssigmentPage()),
                                            ),
                                          );
                                        },
                                        child: Icon(Icons.visibility))
                                    : SizedBox(width: 25)
                              ],
                            ),
                          ))
                      .toList(),
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}
