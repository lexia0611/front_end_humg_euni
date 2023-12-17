// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:fe/model/assignment.model.dart';

class ViewAssigmentStudentCubitState extends Equatable {
  final Status status;
  final AssignmentModel assigmentModel;
  final String fileName;

  const ViewAssigmentStudentCubitState({
    this.status = Status.initial,
    required this.assigmentModel,
    this.fileName = "",
  });

  ViewAssigmentStudentCubitState copyWith({
    Status? status,
    AssignmentModel? assigmentModel,
    String? fileName,
  }) {
    return ViewAssigmentStudentCubitState(
      status: status ?? this.status,
      assigmentModel: assigmentModel ?? this.assigmentModel,
      fileName: fileName ?? this.fileName,
    );
  }

  @override
  List<Object> get props => [status, assigmentModel, fileName];
}

enum Status { initial, loading, success, error }
