// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:fe/model/question.quiz.model.dart';
import 'package:fe/model/quiz.model.dart';

class AnswerQuizCubitState extends Equatable {
  final Status status;
  final QuizModel quizModel;
  final List<QuestionQuizModel> listQuestion;
  final List<int?> listAnswer;

  const AnswerQuizCubitState({
    this.status = Status.initial,
    required this.quizModel,
    this.listQuestion = const [],
    this.listAnswer = const [],
  });

  AnswerQuizCubitState copyWith({
    Status? status,
    QuizModel? quizModel,
    List<QuestionQuizModel>? listQuestion,
    List<int?>? listAnswer,
  }) {
    return AnswerQuizCubitState(
      status: status ?? this.status,
      quizModel: quizModel ?? this.quizModel,
      listQuestion: listQuestion ?? this.listQuestion,
      listAnswer: listAnswer ?? this.listAnswer,
    );
  }

  @override
  List<Object> get props => [status, quizModel, listQuestion.length, listQuestion,listAnswer];
}

enum Status { initial, loading, success, error }
