// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:fe/model/assignment.model.dart';

class ViewAssignmentStudentCubitState extends Equatable {
  final Status status;
  final AssignmentModel assignmentModel;
  final String fileName;

  const ViewAssignmentStudentCubitState({
    this.status = Status.initial,
    required this.assignmentModel,
    this.fileName = "",
  });

  ViewAssignmentStudentCubitState copyWith({
    Status? status,
    AssignmentModel? assignmentModel,
    String? fileName,
  }) {
    return ViewAssignmentStudentCubitState(
      status: status ?? this.status,
      assignmentModel: assignmentModel ?? this.assignmentModel,
      fileName: fileName ?? this.fileName,
    );
  }

  @override
  List<Object> get props => [status, assignmentModel, fileName];
}

enum Status { initial, loading, success, error }
