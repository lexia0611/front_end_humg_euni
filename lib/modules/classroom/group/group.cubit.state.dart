// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:fe/model/group.model.dart';

class GroupCubitState extends Equatable {
  final GroupStatus status;
  final bool isGV;
  final List<GroupModel> listGroup;

  const GroupCubitState({
    this.status = GroupStatus.initial,
    this.isGV = true,
    this.listGroup = const [],
  });

  GroupCubitState copyWith({
    GroupStatus? status,
    bool? isGV,
    List<GroupModel>? listGroup,
  }) {
    return GroupCubitState(
      status: status ?? this.status,
      isGV: isGV ?? this.isGV,
      listGroup: listGroup ?? this.listGroup,
    );
  }

  @override
  List<Object> get props => [status, listGroup, listGroup.length, isGV];
}

enum GroupStatus { initial, loading, success, error }
