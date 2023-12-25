// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:fe/app/widgets/button.not.click.multi.dart';
import 'package:fe/app/widgets/list.load.state.dart';
import 'package:fe/model/class.model.dart';
import 'package:fe/model/group.model.dart';
import 'package:fe/model/message.model.dart';
import 'package:fe/modules/classroom/chat/component/another.message.dart';
import 'package:fe/modules/classroom/chat/component/own.message.dart';
import 'package:fe/modules/classroom/group/chatgroup/chat.group.cubit.dart';
import 'package:fe/modules/classroom/group/chatgroup/list.chat.group.cubit.dart';
import 'package:fe/modules/classroom/group/menbergroup/member.group.page.dart';
import 'package:fe/provider/file.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../menbergroup/member.group.cubit.dart';

class ChatGroupScreen extends StatefulWidget {
  final ClassModel classModel;
  final GroupModel groupModel;
  final String idUser;
  final bool isGV;
  const ChatGroupScreen({
    super.key,
    required this.groupModel,
    required this.idUser,
    required this.classModel,
    required this.isGV,
  });

  @override
  State<ChatGroupScreen> createState() => _ChatGroupScreenState();
}

class _ChatGroupScreenState extends State<ChatGroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context, widget.groupModel);
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
              widget.groupModel.name ?? "",
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              "${widget.groupModel.listGroupMemberModel?.length ?? 0} student",
              style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w300),
            ),
          ],
        ),
        actions: [
          InkWell(
            onTap: () async {
              var response = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => MemberGroupCubit(
                          classModel: widget.classModel,
                          listGroupMember: widget.groupModel.listGroupMemberModel ?? [],
                        ),
                      ),
                    ],
                    child: MemberGroupScreen(
                      groupModel: widget.groupModel,
                      isGV: widget.isGV,
                    ),
                  ),
                ),
              );
              if (response != null) {
                setState(() {
                  widget.groupModel.listGroupMemberModel = response;
                });
              }
            },
            child: Icon(
              Icons.group,
              size: 30,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 10)
        ],
      ),
      body: ButtonNotClickMulti(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: Color.fromARGB(255, 215, 247, 255)),
                  child: BlocBuilder<ListChatGroupCubit, ListLoadState<MessageModel>>(buildWhen: (previous, current) {
                    return previous.status != current.status || previous.list.length != current.list.length;
                  }, builder: (context, state) {
                    var listMess = state.list;
                    return (listMess.isNotEmpty)
                        ? ListView.separated(
                            reverse: true,
                            addAutomaticKeepAlives: true,
                            padding: const EdgeInsets.only(bottom: 10, top: 10),
                            itemBuilder: (context, index) {
                              var message = listMess[index];
                              if (message.createUserId == widget.idUser) {
                                return OwnMessage(
                                  bloc:context.read<ListChatGroupCubit>(),
                                  index,
                                  message,
                                  isShowTime: true,
                                  key: ValueKey('own${message.id}'),
                                );
                              } else {
                                var isShowAvar = true;
                                return AnotherMessage(
                                  message,
                                  isShowAvatar: isShowAvar,
                                  isShowTime: true,
                                  key: ValueKey('another${message.id}'),
                                );
                              }
                            },
                            itemCount: listMess.length,
                            separatorBuilder: (BuildContext context, int index) {
                              return const SizedBox(
                                height: 25,
                              );
                            },
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 150, child: Image.asset("assets/no_message.png")),
                            ],
                          );
                  }),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(width: 5),
                  InkWell(
                      onTap: () async {
                        context.read<ChatGroupCubit>().chatFocus.unfocus();
                        var fileName = await handleUploadFileAll();
                        if (fileName != null) {
                          context.read<ChatGroupCubit>().sendFile(fileName);
                        }
                      },
                      child: Icon(
                        Icons.attach_file,
                        size: 30,
                        color: const Color.fromARGB(255, 21, 123, 207),
                      )),
                  SizedBox(width: 5),
                  InkWell(
                      onTap: () async {
                        context.read<ChatGroupCubit>().chatFocus.unfocus();
                        var fileName = await handleUploadImage();
                        if (fileName != null) {
                          context.read<ChatGroupCubit>().sendImage(fileName);
                        }
                      },
                      child: Icon(
                        Icons.photo_library,
                        size: 30,
                        color: const Color.fromARGB(255, 21, 123, 207),
                      )),
                  SizedBox(width: 5),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), border: Border.all(color: Colors.grey, width: 2)),
                      height: 50,
                      child: TextFormField(
                        onChanged: (value) {},
                        enabled: true,
                        controller: context.read<ChatGroupCubit>().controllerChat,
                        style: TextStyle(),
                        onTap: () {},
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          hintText: "Aa",
                          hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFFBBBBBB)),
                          suffixIconConstraints: const BoxConstraints.expand(width: 30, height: 20),
                          contentPadding: const EdgeInsets.only(left: 10, right: 8, top: 8, bottom: 8),
                          isCollapsed: true,
                          border: InputBorder.none,
                        ),
                        focusNode: context.read<ChatGroupCubit>().chatFocus,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 81, 168, 238),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: InkWell(
                      onTap: () {
                        context.read<ChatGroupCubit>().sendText();
                      },
                      child: Center(
                        child: Icon(Icons.send, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                ],
              ),
              SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
