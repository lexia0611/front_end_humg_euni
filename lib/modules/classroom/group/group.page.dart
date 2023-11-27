// ignore_for_file: use_build_context_synchronously

import 'package:fe/app/widgets/button.not.click.multi.dart';
import 'package:fe/model/class.model.dart';
import 'package:fe/model/group.model.dart';
import 'package:fe/modules/classroom/group/chatgroup/chat.group.cubit.dart';
import 'package:fe/modules/classroom/group/chatgroup/list.chat.group.cubit.dart';
import 'package:fe/modules/classroom/group/handle/edit.group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chatgroup/chat.group.page.dart';
import 'group.cubit.dart';
import 'group.cubit.state.dart';
import 'handle/create.group.dart';
import 'handle/delete.group.dart';

class GroupPage extends StatefulWidget {
  final ClassModel classModel;
  const GroupPage({super.key, required this.classModel});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  List<GroupModel> listGroup = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupCubit, GroupCubitState>(
      builder: (context, state) {
        if (state.status == GroupStatus.loading) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.blue,
          ));
        }
        listGroup = state.listGroup;
        return Scaffold(
          body: Container(
              margin: const EdgeInsets.all(10),
              child: ListView.separated(
                itemCount: listGroup.length,
                separatorBuilder: (BuildContext context, int index) => const Row(),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(15),
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
                          spreadRadius: 5,
                          blurRadius: 8,
                          offset: const Offset(3, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ButtonNotClickMulti(
                      onTap: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        String? idUSer = prefs.getString("id");
                        var response = await Navigator.push<GroupModel>(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                    create: (context) => ListChatGroupCubit(groupModel: listGroup[index]),
                                  ),
                                  BlocProvider(
                                    create: (context) => ChatGroupCubit(groupModel: listGroup[index]),
                                  ),
                                ],
                                child: ChatGroupScreen(
                                  groupModel: listGroup[index],
                                  idUser: idUSer ?? "",
                                  classModel: widget.classModel,
                                  isGV: state.isGV,
                                )),
                          ),
                        );
                        if (response != null) {
                          setState(() {
                            listGroup[index] = response;
                          });
                        }
                      },
                      child: Row(
                        children: [
                          ClipOval(
                            child: Container(
                              decoration: const BoxDecoration(color: Colors.blue),
                              width: 70,
                              height: 70,
                              child: (state.listGroup[index].avatar != null && state.listGroup[index].avatar != "")
                                  ? Image.network(
                                      state.listGroup[index].avatar ?? "",
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      "assets/group.png",
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.listGroup[index].name ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  state.listGroup[index].description ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "Sĩ số: ${state.listGroup[index].listGroupMemberModel?.length ?? 0}",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          (state.isGV)
                              ? Column(
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          var response = await showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return EditGroup(groupModel: state.listGroup[index]);
                                              });
                                          if (response != null && response.runtimeType == GroupModel) {
                                            setState(() {
                                              state.listGroup[index] = response;
                                            });
                                          }
                                        },
                                        child: const Center(
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          var response = await showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return DeleteGroup(groupModel: state.listGroup[index]);
                                              });
                                          if (response != null && response == true) {
                                            context.read<GroupCubit>().getListGroup();
                                          }
                                        },
                                        child: const Center(
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : const SizedBox.shrink()
                        ],
                      ),
                    ),
                  );
                },
              )),
          floatingActionButton: (state.isGV)
              ? Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.blue),
                  child: InkWell(
                    onTap: () async {
                      var response = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CreateGroup(classModel: widget.classModel);
                          });
                      if (response != null && response == true) {
                        context.read<GroupCubit>().getListGroup();
                      }
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                )
              : null,
        );
      },
    );
  }
}
