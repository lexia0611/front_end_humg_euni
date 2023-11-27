// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:fe/model/assigment.model.dart';

class AssigmentTeacherCubitState extends Equatable {
  final AssigmentStatus status;
  final bool isGV;
  final List<AssigmentModel> listAssigment;

  const AssigmentTeacherCubitState({
    this.status = AssigmentStatus.initial,
    this.isGV = true,
    this.listAssigment = const [],
  });

  AssigmentTeacherCubitState copyWith({
    AssigmentStatus? status,
    bool? isGV,
    List<AssigmentModel>? listAssigment,
  }) {
    return AssigmentTeacherCubitState(
      status: status ?? this.status,
      isGV: isGV ?? this.isGV,
      listAssigment: listAssigment ?? this.listAssigment,
    );
  }

  @override
  List<Object> get props => [status, listAssigment, listAssigment.length, isGV];
}

enum AssigmentStatus { initial, loading, success, error }
