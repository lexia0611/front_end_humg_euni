import 'dart:async';

import 'package:fe/app/widgets/list.load.state.dart';
import 'package:fe/model/group.model.dart';
import 'package:fe/model/message.model.dart';
import 'package:fe/provider/chat.provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListChatGroupCubit extends Cubit<ListLoadState<MessageModel>> {
  final ScrollController scrollController = ScrollController();
  final GroupModel groupModel;
  bool isFirst = true;
  late StreamSubscription<MessageModel> _streamMessage;

  ListChatGroupCubit({
    required this.groupModel,
  }) : super(const ListLoadState()) {
    startStreamComment();
  }
  startStreamComment() async {
    await getListComment();
    _streamMessage = ChatProvider().messageGroupStream(groupModel.id.toString()).listen((event) async {
      if (isFirst) {
        isFirst = false;
      } else {
        emit(state.copyWith(list: [event, ...state.list]));
      }
    });
  }

  void edit(int id, String message, MessageModel messageModel) {
    emit(state.copyWith(status: ListLoadStatus.loading));
    var list = state.list;
    list[id].message = message;
    messageModel.message = message;
    // ChatProvider().editMess(messageModel.id);
    emit(state.copyWith(list: list, status: ListLoadStatus.success));
  }

  void delete(MessageModel messageModel) {
    emit(state.copyWith(status: ListLoadStatus.loading));
    var list = state.list;
    list.remove(messageModel);
    ChatProvider().deleteMess(messageModel.id ?? 0);
    emit(state.copyWith(list: list, status: ListLoadStatus.success));
  }

  Future<void> getListComment() async {
    var listChat = await ChatProvider().getMessAll(groupModel.id.toString(), false);
    emit(state.copyWith(list: listChat));
  }

  @override
  Future<void> close() async {
    _streamMessage.cancel();
    return super.close();
  }
}
