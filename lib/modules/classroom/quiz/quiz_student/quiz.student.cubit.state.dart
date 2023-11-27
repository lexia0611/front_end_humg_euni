// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:fe/model/quiz.model.dart';

class QuizStudentCubitState extends Equatable {
  final Status status;
  final List<QuizModel> listQuizModel;

  const QuizStudentCubitState({
    this.status = Status.initial,
    this.listQuizModel = const [],
  });

  QuizStudentCubitState copyWith({
    Status? status,
    bool? isGV,
    List<QuizModel>? listQuizModel,
  }) {
    return QuizStudentCubitState(
      status: status ?? this.status,
      listQuizModel: listQuizModel ?? this.listQuizModel,
    );
  }

  @override
  List<Object> get props => [status, listQuizModel, listQuizModel.length];
}

enum Status { initial, loading, success, error }
