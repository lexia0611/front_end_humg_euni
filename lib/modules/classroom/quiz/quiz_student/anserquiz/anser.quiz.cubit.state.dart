// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:fe/model/question.quiz.model.dart';
import 'package:fe/model/quiz.model.dart';

class AnserQuizCubitState extends Equatable {
  final Status status;
  final QuizModel quizModel;
  final List<QuestionQuizModel> listQuestion;
  final List<int?> listAnser;

  const AnserQuizCubitState({
    this.status = Status.initial,
    required this.quizModel,
    this.listQuestion = const [],
    this.listAnser = const [],
  });

  AnserQuizCubitState copyWith({
    Status? status,
    QuizModel? quizModel,
    List<QuestionQuizModel>? listQuestion,
    List<int?>? listAnser,
  }) {
    return AnserQuizCubitState(
      status: status ?? this.status,
      quizModel: quizModel ?? this.quizModel,
      listQuestion: listQuestion ?? this.listQuestion,
      listAnser: listAnser ?? this.listAnser,
    );
  }

  @override
  List<Object> get props => [status, quizModel, listQuestion.length, listQuestion,listAnser];
}

enum Status { initial, loading, success, error }
