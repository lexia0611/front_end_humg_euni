// ignore_for_file: prefer_const_constructors

import 'package:fe/provider/file.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'view.assignment.student.cubit.dart';
import 'view.assignment.student.cubit.state.dart';

class ViewAssignmentStudentPage extends StatelessWidget {
  const ViewAssignmentStudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewAssignmentStudentCubit, ViewAssignmentStudentCubitState>(
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
                    state.assignmentModel.title ?? "",
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Status: ${state.assignmentModel.status == 1 ? "Active" : "Done"}",
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
                  state.assignmentModel.title ?? "",
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Status: ${state.assignmentModel.status == 1 ? "Active" : "Done"}",
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
                    Expanded(child: Text("Created time", style: TextStyle(fontSize: 14, color: const Color.fromARGB(255, 58, 58, 58)))),
                    SizedBox(width: 20),
                    Expanded(
                      flex: 3,
                      child: Text(
                        DateFormat("HH:mm dd/MM/yyyy").format(DateTime.parse(state.assignmentModel.createTime ?? "").toLocal()),
                      ),
                    )
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    SizedBox(width: 20),
                    Expanded(child: Text("Expired", style: TextStyle(fontSize: 14, color: const Color.fromARGB(255, 58, 58, 58)))),
                    SizedBox(width: 20),
                    Expanded(
                      flex: 3,
                      child: Text(
                        DateFormat("HH:mm dd/MM/yyyy").format(DateTime.parse(state.assignmentModel.dueDay ?? "").toLocal()),
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
                      child: state.assignmentModel.fileName != null
                          ? InkWell(
                              onTap: () {
                                downloadFile(context, state.assignmentModel.fileName!);
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Submit",
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                (state.assignmentModel.assignmentStudentModel?.point == null)
                    ? Center(
                        child: IconButton(
                          onPressed: () async {
                            context.read<ViewAssignmentStudentCubit>().uploadFile();
                          },
                          icon: Icon(
                            Icons.cloud_upload,
                            color: Colors.blue,
                            size: 50,
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                SizedBox(height: 10),
                state.fileName != ""
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(state.fileName),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<ViewAssignmentStudentCubit>().sendAssignment();
                                },
                                child: Text(
                                  "Send",
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    : SizedBox.shrink(),
                Divider(),
                Row(
                  children: [
                    SizedBox(width: 20),
                    Expanded(child: Text("File sent", style: TextStyle(fontSize: 14, color: const Color.fromARGB(255, 58, 58, 58)))),
                    SizedBox(width: 20),
                    Expanded(
                      flex: 3,
                      child: state.assignmentModel.assignmentStudentModel?.fileName != null
                          ? InkWell(
                              onTap: () {
                                downloadFile(context, state.assignmentModel.assignmentStudentModel?.fileName ?? "");
                              },
                              child: Text(
                                state.assignmentModel.assignmentStudentModel?.fileName ?? "",
                                style: TextStyle(color: Colors.blue),
                              ))
                          : SizedBox.shrink(),
                    ),
                  ],
                ),
                Divider(),
                (state.assignmentModel.assignmentStudentModel?.point == null)
                    ? Row(
                        children: [
                          SizedBox(width: 20),
                          Expanded(child: Text("Time sent", style: TextStyle(fontSize: 14, color: const Color.fromARGB(255, 58, 58, 58)))),
                          SizedBox(width: 20),
                          Expanded(
                            flex: 3,
                            child: Text(
                              state.assignmentModel.assignmentStudentModel?.modifiedDate != null ? DateFormat("HH:mm dd/MM/yyyy").format(DateTime.parse(state.assignmentModel.assignmentStudentModel?.modifiedDate ?? "").toLocal()) : "",
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
                              state.assignmentModel.assignmentStudentModel?.createTime != null ? DateFormat("HH:mm dd/MM/yyyy").format(DateTime.parse(state.assignmentModel.assignmentStudentModel?.createTime ?? "").toLocal()) : "",
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
                      child: Text((state.assignmentModel.assignmentStudentModel?.point != null) ? state.assignmentModel.assignmentStudentModel!.point.toString() : ""),
                    ),
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
