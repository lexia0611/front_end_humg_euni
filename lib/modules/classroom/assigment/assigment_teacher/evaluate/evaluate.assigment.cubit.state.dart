// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:fe/model/assignment.student.model.dart';

class EvaluateAssignmentCubitState extends Equatable {
  final Status status;
  final AssignmentStudentModel assignmentStudentModel;
  final bool showButton;

  const EvaluateAssignmentCubitState({
    this.status = Status.initial,
    required this.assignmentStudentModel,
    this.showButton = false,
  });

  EvaluateAssignmentCubitState copyWith({
    Status? status,
    bool? showButton,
    AssignmentStudentModel? assignmentStudentModel,
  }) {
    return EvaluateAssignmentCubitState(
      status: status ?? this.status,
      showButton: showButton ?? this.showButton,
      assignmentStudentModel: assignmentStudentModel ?? this.assignmentStudentModel,
    );
  }

  @override
  List<Object> get props => [
        status,
        assignmentStudentModel,
        showButton,
      ];
}

enum Status { initial, loading, success, error }
