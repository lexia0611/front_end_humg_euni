import 'dart:async';

import 'package:fe/app/widgets/list.load.state.dart';
import 'package:fe/model/class.model.dart';
import 'package:fe/model/message.model.dart';
import 'package:fe/provider/chat.provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListChatCubit extends Cubit<ListLoadState<MessageModel>> {
  final ScrollController scrollController = ScrollController();
  final ClassModel classModel;
  bool isFirst = true;
  late StreamSubscription<MessageModel> _streamMessage;

  ListChatCubit({
    required this.classModel,
  }) : super(const ListLoadState()) {
    scrollController.addListener(_onScroll);
    startStreamComment();
  }
  startStreamComment() async {
    await getListMessage();
    _streamMessage = ChatProvider().messageStream(classModel.id.toString()).listen((event) async {
      if (isFirst) {
        isFirst = false;
      } else {
        emit(state.copyWith(list: [event, ...state.list]));
      }
    });
  }

  Future<void> getListMessage() async {
    var listChat = await ChatProvider().getMessAll(classModel.id ?? "", true);
    emit(state.copyWith(list: listChat));
  }

  void edit(int id, String message, MessageModel messageModel) {
    emit(state.copyWith(status: ListLoadStatus.loading));
    var list = state.list;
    list[id].message = message;
    messageModel.message = message;
    ChatProvider().editMess(messageModel, true);
    emit(state.copyWith(list: list, status: ListLoadStatus.success));
  }

  void delete(MessageModel messageModel) {
    emit(state.copyWith(status: ListLoadStatus.loading));
    var list = state.list;
    list.remove(messageModel);
    ChatProvider().deleteMess(messageModel.id ?? 0);
    emit(state.copyWith(list: list, status: ListLoadStatus.success));
  }



  @override
  Future<void> close() async {
    _streamMessage.cancel();
    return super.close();
  }

  Future<void> _onScroll() async {
    // var token = await MySharedPreferences.getToken();
    // if (state.status == ListLoadStatus.loading) return;
    // if ((scrollController.position.extentAfter < 100) && (scrollController.position.extentBefore > 0)) {
    //   if (state.status != ListLoadStatus.loadmore && state.isFullStatus != IsFullStatus.isfull) {
    //     emit(state.copyWith(status: ListLoadStatus.loadmore));
    //     var listAddMore = await _liveStreamRepository.getCommentsMore(roomModel.id, token);
    //     if (listAddMore.isEmpty) {
    //       emit(state.copyWith(status: ListLoadStatus.success, isFullStatus: IsFullStatus.isfull));
    //     } else {
    //       emit(state.copyWith(status: ListLoadStatus.success, list: [...state.list, ...listAddMore]));
    //     }
    //   }
    // }
  }
}
