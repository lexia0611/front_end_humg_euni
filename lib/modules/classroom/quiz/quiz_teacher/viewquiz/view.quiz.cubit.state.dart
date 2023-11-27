// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:fe/model/question.quiz.model.dart';
import 'package:fe/model/quiz.anser.model.dart';
import 'package:fe/model/quiz.model.dart';
import 'package:fe/model/sinh.vien.model.dart';

class ViewQuizCubitState extends Equatable {
  final Status status;
  final QuizModel quizModel;
  final List<QuestionQuizModel> listQuestion;
  final List<StudentModel> listStudent;
  final List<QuizAnserModel?> listAnser;

  const ViewQuizCubitState({
    this.status = Status.initial,
    required this.quizModel,
    this.listQuestion = const [],
    this.listStudent = const [],
    this.listAnser = const [],
  });

  ViewQuizCubitState copyWith({
    Status? status,
    QuizModel? quizModel,
    List<QuestionQuizModel>? listQuestion,
    List<StudentModel>? listStudent,
    List<QuizAnserModel?>? listAnser,
  }) {
    return ViewQuizCubitState(
      status: status ?? this.status,
      quizModel: quizModel ?? this.quizModel,
      listQuestion: listQuestion ?? this.listQuestion,
      listStudent: listStudent ?? this.listStudent,
      listAnser: listAnser ?? this.listAnser,
    );
  }

  @override
  List<Object> get props => [status, listAnser, listAnser.length, quizModel, listQuestion, listQuestion.length, listStudent, listStudent.length];
}

enum Status { initial, loading, success, error }
