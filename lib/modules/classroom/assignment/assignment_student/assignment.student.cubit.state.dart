// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:fe/model/assignment.model.dart';

class AssignmentStudentCubitState extends Equatable {
  final AssignmentStatus status;
  final List<AssignmentModel> listAssignment;

  const AssignmentStudentCubitState({
    this.status = AssignmentStatus.initial,
    this.listAssignment = const [],
  });

  AssignmentStudentCubitState copyWith({
    AssignmentStatus? status,
    bool? isGV,
    List<AssignmentModel>? listAssignment,
  }) {
    return AssignmentStudentCubitState(
      status: status ?? this.status,
      listAssignment: listAssignment ?? this.listAssignment,
    );
  }

  @override
  List<Object> get props => [status, listAssignment, listAssignment.length];
}

enum AssignmentStatus { initial, loading, success, error }
