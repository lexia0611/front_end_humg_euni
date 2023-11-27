// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:fe/model/assigment.model.dart';
import 'package:fe/model/assigment.student.model.dart';

class ViewAssigmentCubitState extends Equatable {
  final Status status;
  final List<AssigmentStudentModel> listAssigmentStudentModel;
  final AssigmentModel assigmentModel;

  const ViewAssigmentCubitState({
    this.status = Status.initial,
    this.listAssigmentStudentModel = const [],
    required this.assigmentModel,
  });

  ViewAssigmentCubitState copyWith({
    Status? status,
    bool? isGV,
    List<AssigmentStudentModel>? listAssigmentStudentModel,
    AssigmentModel? assigmentModel,
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
