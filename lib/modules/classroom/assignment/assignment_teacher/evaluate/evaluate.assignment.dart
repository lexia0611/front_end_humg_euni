// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:fe/provider/file.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'evaluate.assignment.cubit.dart';
import 'evaluate.assignment.cubit.state.dart';

class EvaluateAssignmentPage extends StatelessWidget {
  const EvaluateAssignmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EvaluateAssignmentCubit, EvaluateAssignmentCubitState>(
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
                    "${state.assignmentStudentModel.student?.ho_lot ?? ""} ${state.assignmentStudentModel.student?.ten ?? ""}",
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Code: ${state.assignmentStudentModel.username}",
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
                  "${state.assignmentStudentModel.student?.ho_lot ?? ""} ${state.assignmentStudentModel.student?.ten ?? ""}",
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Code: ${state.assignmentStudentModel.username}",
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
                    Expanded(child: Text("File sent", style: TextStyle(fontSize: 14, color: const Color.fromARGB(255, 58, 58, 58)))),
                    SizedBox(width: 20),
                    Expanded(
                      flex: 3,
                      child: state.assignmentStudentModel.fileName != null
                          ? InkWell(
                              onTap: () {
                                downloadFile(context, state.assignmentStudentModel.fileName ?? "");
                              },
                              child: Text(
                                state.assignmentStudentModel.fileName ?? "",
                                style: TextStyle(color: Colors.blue),
                              ))
                          : SizedBox.shrink(),
                    ),
                  ],
                ),
                Divider(),
                (state.assignmentStudentModel.point == null)
                    ? Row(
                        children: [
                          SizedBox(width: 20),
                          Expanded(child: Text("Time sent", style: TextStyle(fontSize: 14, color: const Color.fromARGB(255, 58, 58, 58)))),
                          SizedBox(width: 20),
                          Expanded(
                            flex: 3,
                            child: Text(
                              state.assignmentStudentModel.modifiedDate != null ? DateFormat("HH:mm dd/MM/yyyy").format(DateTime.parse(state.assignmentStudentModel.modifiedDate ?? "").toLocal()) : "",
                            ),
                          )
                        ],
                      )
                    : Row(
                        children: [
                          SizedBox(width: 20),
                          Expanded(child: Text("Time sent", style: TextStyle(fontSize: 14, color: const Color.fromARGB(255, 58, 58, 58)))),
                          SizedBox(width: 20),
                          Expanded(
                            flex: 3,
                            child: Text(
                              state.assignmentStudentModel.createTime != null ? DateFormat("HH:mm dd/MM/yyyy").format(DateTime.parse(state.assignmentStudentModel.createTime ?? "").toLocal()) : "",
                            ),
                          )
                        ],
                      ),
                Divider(),
                Row(
                  children: [
                    SizedBox(width: 20),
                    Expanded(child: Text("Point", style: TextStyle(fontSize: 14, color: const Color.fromARGB(255, 58, 58, 58)))),
                    SizedBox(width: 20),
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey), borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.only(left: 10, right: 10)),
                          controller: context.read<EvaluateAssignmentCubit>().point,
                          onChanged: (value) {
                            context.read<EvaluateAssignmentCubit>().changeInput();
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    InkWell(
                      onTap: (state.showButton)
                          ? () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              context.read<EvaluateAssignmentCubit>().sendPoint();
                            }
                          : null,
                      child: Icon(
                        Icons.send,
                        color: (state.showButton) ? Colors.blue : Colors.black,
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
