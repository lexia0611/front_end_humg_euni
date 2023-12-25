// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:fe/model/assignment.model.dart';
import 'package:fe/model/assignment.student.model.dart';

class ViewAssignmentCubitState extends Equatable {
  final Status status;
  final List<AssignmentStudentModel> listAssignmentStudentModel;
  final AssignmentModel assignmentModel;

  const ViewAssignmentCubitState({
    this.status = Status.initial,
    this.listAssignmentStudentModel = const [],
    required this.assignmentModel,
  });

  ViewAssignmentCubitState copyWith({
    Status? status,
    bool? isGV,
    List<AssignmentStudentModel>? listAssignmentStudentModel,
    AssignmentModel? assignmentModel,
  }) {
    return ViewAssignmentCubitState(
      status: status ?? this.status,
      listAssignmentStudentModel: listAssignmentStudentModel ?? this.listAssignmentStudentModel,
      assignmentModel: assignmentModel ?? this.assignmentModel,
    );
  }

  @override
  List<Object> get props => [status, assignmentModel, listAssignmentStudentModel, listAssignmentStudentModel.length];
}

enum Status { initial, loading, success, error }
