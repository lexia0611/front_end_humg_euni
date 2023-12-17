// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:fe/model/assignment.model.dart';

class AssigmentStudentCubitState extends Equatable {
  final AssigmentStatus status;
  final List<AssignmentModel> listAssigment;

  const AssigmentStudentCubitState({
    this.status = AssigmentStatus.initial,
    this.listAssigment = const [],
  });

  AssigmentStudentCubitState copyWith({
    AssigmentStatus? status,
    bool? isGV,
    List<AssignmentModel>? listAssigment,
  }) {
    return AssigmentStudentCubitState(
      status: status ?? this.status,
      listAssigment: listAssigment ?? this.listAssigment,
    );
  }

  @override
  List<Object> get props => [status, listAssigment, listAssigment.length];
}

enum AssigmentStatus { initial, loading, success, error }
