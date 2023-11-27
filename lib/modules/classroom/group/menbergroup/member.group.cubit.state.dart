// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:fe/model/group.member.dart';
import 'package:fe/model/sinh.vien.model.dart';

class MemberGroupCubitState extends Equatable {
  final MemberGroupStatus status;
  final bool isGV;
  final List<GroupMemberModel> listGroupMemberModel;
  final List<StudentModel> listStudentClass;

  const MemberGroupCubitState({
    this.status = MemberGroupStatus.initial,
    this.isGV = true,
    this.listGroupMemberModel = const [],
    this.listStudentClass = const [],
  });

  MemberGroupCubitState copyWith({
    MemberGroupStatus? status,
    bool? isGV,
    List<GroupMemberModel>? listGroupMemberModel,
    List<StudentModel>? listStudentClass,
  }) {
    return MemberGroupCubitState(
      status: status ?? this.status,
      isGV: isGV ?? this.isGV,
      listGroupMemberModel: listGroupMemberModel ?? this.listGroupMemberModel,
      listStudentClass: listStudentClass ?? this.listStudentClass,

    );
  }

  @override
  List<Object> get props => [status, listGroupMemberModel, listGroupMemberModel.length, listStudentClass, listStudentClass.length];
}

enum MemberGroupStatus { initial, loading, success, error }
