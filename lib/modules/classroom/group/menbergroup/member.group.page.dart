// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
import 'package:fe/model/group.member.dart';
import 'package:fe/model/group.model.dart';
import 'package:fe/model/sinh.vien.model.dart';
import 'package:fe/modules/classroom/list_sinhvien/view.sinh.vien.dart';
import 'package:fe/provider/group.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dialog.add.member.dart';
import 'member.group.cubit.dart';
import 'member.group.cubit.state.dart';

class MemberGroupScreen extends StatefulWidget {
  final GroupModel groupModel;
  final bool isGV;
  const MemberGroupScreen({super.key, required this.groupModel, required this.isGV});

  @override
  State<MemberGroupScreen> createState() => _MemberGroupScreenState();
}

class _MemberGroupScreenState extends State<MemberGroupScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberGroupCubit, MemberGroupCubitState>(
      builder: (context, state) {
        if (state.status == MemberGroupStatus.loading) {
          return Center(
              child: CircularProgressIndicator(
            color: Colors.blue,
          ));
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context, state.listGroupMemberModel);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                size: 30,
                color: Colors.white,
              ),
            ),
            title: Center(
              child: Text(
                "Member Group",
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            actions: [
              widget.isGV
                  ? InkWell(
                      onTap: () async {
                        // DialogAddMember
                        var callBackData = await showDialog<CallBackData>(
                            context: context,
                            builder: (BuildContext context) {
                              return DialogAddMember(
                                listStudentClass: state.listStudentClass,
                              );
                            });

                        if (callBackData != null) {
                          context.read<MemberGroupCubit>().updateListStudentClass(callBackData.listStudentClassNew);
                          List<GroupMemberModel> listGroupMemberStart = [];
                          if (callBackData.listStudentAdd.isNotEmpty) {
                            for (var item in callBackData.listStudentAdd) {
                              var itemGroupMember = await GroupProvider.addMember(widget.groupModel.id ?? 0, item.ma_sinh_vien ?? "");
                              itemGroupMember.student = item;
                              listGroupMemberStart.add(itemGroupMember);
                            }
                          }
                          var listStudentNew = [...state.listGroupMemberModel, ...listGroupMemberStart];
                          context.read<MemberGroupCubit>().updateListStudent(listStudentNew);
                        }
                      },
                      child: Icon(
                        Icons.person_add,
                        size: 30,
                        color: Colors.white,
                      ),
                    )
                  : SizedBox(width: 35),
              SizedBox(width: 10)
            ],
          ),
          body: ListView(
            children: state.listGroupMemberModel.map((element) {
              return Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 79, 79, 79).withOpacity(0.5),
                      blurRadius: 8,
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => ViewSinhvien(
                          sinhVienModel: element.student ?? StudentModel(),
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${element.student?.ho_lot ?? ""} ${element.student?.ten ?? ""} - ${element.student?.ma_sinh_vien}",
                              style: TextStyle(fontSize: 17),
                            ),
                            Text(
                              "${element.student?.ten_lop}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              "Email: ${element.student?.e_mail}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              "Phone: ${element.student?.dien_thoai ?? ""}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      widget.isGV
                          ? InkWell(
                              onTap: () {
                                context.read<MemberGroupCubit>().removeListStudent(element);
                                context.read<MemberGroupCubit>().addListStudentClass(element.student ?? StudentModel());
                              },
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 30,
                              ),
                            )
                          : SizedBox.shrink()
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class CallBackData {
  List<StudentModel> listStudentAdd;
  List<StudentModel> listStudentClassNew;
  CallBackData({required this.listStudentAdd, required this.listStudentClassNew});
}
