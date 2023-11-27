// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:fe/model/question.quiz.model.dart';
import 'package:fe/model/quiz.model.dart';

class UpdateQuizCubitState extends Equatable {
  final Status status;
  final QuizModel quizModel;
  final List<QuestionQuizModel> listQuestion;

  const UpdateQuizCubitState({
    this.status = Status.initial,
    required this.quizModel,
    this.listQuestion = const [],
  });

  UpdateQuizCubitState copyWith({
    Status? status,
    QuizModel? quizModel,
    List<QuestionQuizModel>? listQuestion,
  }) {
    return UpdateQuizCubitState(
      status: status ?? this.status,
      quizModel: quizModel ?? this.quizModel,
      listQuestion: listQuestion ?? this.listQuestion,
    );
  }

  @override
  List<Object?> get props => [status, listQuestion, listQuestion.length, quizModel];
}

enum Status { initial, loading, success, successEdit, error , notNull, successChangeStatus}
