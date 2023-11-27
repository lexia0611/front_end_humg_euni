// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:fe/model/quiz.model.dart';

class QuizTeacherCubitState extends Equatable {
  final AssigmentStatus status;
  final bool isGV;
  final List<QuizModel> listQuizModel;

  const QuizTeacherCubitState({
    this.status = AssigmentStatus.initial,
    this.isGV = true,
    this.listQuizModel = const [],
  });

  QuizTeacherCubitState copyWith({
    AssigmentStatus? status,
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

enum AssigmentStatus { initial, loading, success, error }
