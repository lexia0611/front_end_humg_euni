// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:fe/model/assignment.model.dart';
import 'package:fe/model/assignment.student.model.dart';

class ViewAssigmentCubitState extends Equatable {
  final Status status;
  final List<AssignmentStudentModel> listAssigmentStudentModel;
  final AssignmentModel assigmentModel;

  const ViewAssigmentCubitState({
    this.status = Status.initial,
    this.listAssigmentStudentModel = const [],
    required this.assigmentModel,
  });

  ViewAssigmentCubitState copyWith({
    Status? status,
    bool? isGV,
    List<AssignmentStudentModel>? listAssigmentStudentModel,
    AssignmentModel? assigmentModel,
  }) {
    return ViewAssigmentCubitState(
      status: status ?? this.status,
      listAssigmentStudentModel: listAssigmentStudentModel ?? this.listAssigmentStudentModel,
      assigmentModel: assigmentModel ?? this.assigmentModel,
    );
  }

  @override
  List<Object> get props => [status, assigmentModel, listAssigmentStudentModel, listAssigmentStudentModel.length];
}

enum Status { initial, loading, success, error }
