// ignore_for_file: prefer_const_constructors

import 'package:fe/provider/file.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'view.assigment.student.cubit.dart';
import 'view.assigment.student.cubit.state.dart';

class ViewAssigmentStudentPage extends StatelessWidget {
  const ViewAssigmentStudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewAssigmentStudentCubit, ViewAssigmentStudentCubitState>(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Submit",
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                (state.assigmentModel.assignmentStudentModel?.point == null)
                    ? Center(
                        child: IconButton(
                          onPressed: () async {
                            context.read<ViewAssigmentStudentCubit>().uploadFile();
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
                                  context.read<ViewAssigmentStudentCubit>().sendAssigment();
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
                      child: state.assigmentModel.assignmentStudentModel?.fileName != null
                          ? InkWell(
                              onTap: () {
                                downloadFile(context, state.assigmentModel.assignmentStudentModel?.fileName ?? "");
                              },
                              child: Text(
                                state.assigmentModel.assignmentStudentModel?.fileName ?? "",
                                style: TextStyle(color: Colors.blue),
                              ))
                          : SizedBox.shrink(),
                    ),
                  ],
                ),
                Divider(),
                (state.assigmentModel.assignmentStudentModel?.point == null)
                    ? Row(
                        children: [
                          SizedBox(width: 20),
                          Expanded(child: Text("Time sent", style: TextStyle(fontSize: 14, color: const Color.fromARGB(255, 58, 58, 58)))),
                          SizedBox(width: 20),
                          Expanded(
                            flex: 3,
                            child: Text(
                              state.assigmentModel.assignmentStudentModel?.modifiedDate != null ? DateFormat("HH:mm dd/MM/yyyy").format(DateTime.parse(state.assigmentModel.assignmentStudentModel?.modifiedDate ?? "").toLocal()) : "",
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
                              state.assigmentModel.assignmentStudentModel?.createTime != null ? DateFormat("HH:mm dd/MM/yyyy").format(DateTime.parse(state.assigmentModel.assignmentStudentModel?.createTime ?? "").toLocal()) : "",
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
                      child: Text((state.assigmentModel.assignmentStudentModel?.point != null) ? state.assigmentModel.assignmentStudentModel!.point.toString() : ""),
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
