// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:fe/model/quiz.model.dart';

class QuizTeacherCubitState extends Equatable {
  final AssignmentStatus status;
  final bool isGV;
  final List<QuizModel> listQuizModel;

  const QuizTeacherCubitState({
    this.status = AssignmentStatus.initial,
    this.isGV = true,
    this.listQuizModel = const [],
  });

  QuizTeacherCubitState copyWith({
    AssignmentStatus? status,
    bool? isGV,
    List<QuizModel>? listQuizModel,
  }) {
    return QuizTeacherCubitState(
      status: status ?? this.status,
      isGV: isGV ?? this.isGV,
      listQuizModel: listQuizModel ?? this.listQuizModel,
    );
  }

  @override
  List<Object> get props => [status, listQuizModel, listQuizModel.length, isGV];
}

enum AssignmentStatus { initial, loading, success, error }
