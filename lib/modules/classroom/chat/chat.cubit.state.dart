// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:fe/model/message.model.dart';

class ChatCubitState extends Equatable {
  final CommentStatus status;
  final List<MessageModel> listMess;

  const ChatCubitState({
    this.status = CommentStatus.initial,
    this.listMess = const [],
  });

  ChatCubitState copyWith({
    CommentStatus? status,
    List<MessageModel>? listMess,
  }) {
    return ChatCubitState(
      status: status ?? this.status,
      listMess: listMess ?? this.listMess,
    );
  }

  @override
  List<Object> get props =>
      [status, listMess, listMess.length];
}

enum CommentStatus { initial, focusComment }
