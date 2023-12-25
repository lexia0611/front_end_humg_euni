// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:fe/model/assignment.model.dart';

class AssignmentTeacherCubitState extends Equatable {
  final AssignmentStatus status;
  final bool isGV;
  final List<AssignmentModel> listAssignment;

  const AssignmentTeacherCubitState({
    this.status = AssignmentStatus.initial,
    this.isGV = true,
    this.listAssignment = const [],
  });

  AssignmentTeacherCubitState copyWith({
    AssignmentStatus? status,
    bool? isGV,
    List<AssignmentModel>? listAssignment,
  }) {
    return AssignmentTeacherCubitState(
      status: status ?? this.status,
      isGV: isGV ?? this.isGV,
      listAssignment: listAssignment ?? this.listAssignment,
    );
  }

  @override
  List<Object> get props => [status, listAssignment, listAssignment.length, isGV];
}

enum AssignmentStatus { initial, loading, success, error }
