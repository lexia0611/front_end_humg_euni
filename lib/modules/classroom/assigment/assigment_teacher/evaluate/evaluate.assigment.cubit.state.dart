// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:fe/model/assigment.student.model.dart';

class EvaluateAssigmentCubitState extends Equatable {
  final Status status;
  final AssigmentStudentModel assigmentStudentModel;
  final bool showButton;

  const EvaluateAssigmentCubitState({
    this.status = Status.initial,
    required this.assigmentStudentModel,
    this.showButton = false,
  });

  EvaluateAssigmentCubitState copyWith({
    Status? status,
    bool? showButton,
    AssigmentStudentModel? assigmentStudentModel,
  }) {
    return EvaluateAssigmentCubitState(
      status: status ?? this.status,
      showButton: showButton ?? this.showButton,
      assigmentStudentModel: assigmentStudentModel ?? this.assigmentStudentModel,
    );
  }

  @override
  List<Object> get props => [
        status,
        assigmentStudentModel,
        showButton,
      ];
}

enum Status { initial, loading, success, error }
