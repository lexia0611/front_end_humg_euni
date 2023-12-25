import 'package:equatable/equatable.dart';
import 'package:fe/model/question.quiz.model.dart';
import 'package:fe/model/quiz.answer.model.dart';
import 'package:fe/model/quiz.model.dart';
import 'package:fe/model/sinh.vien.model.dart';

class ViewQuizCubitState extends Equatable {
  final Status status;
  final QuizModel quizModel;
  final List<QuestionQuizModel> listQuestion;
  final List<StudentModel> listStudent;
  final List<QuizAnswerModel?> listAnswer;

  const ViewQuizCubitState({
    this.status = Status.initial,
    required this.quizModel,
    this.listQuestion = const [],
    this.listStudent = const [],
    this.listAnswer = const [],
  });

  ViewQuizCubitState copyWith({
    Status? status,
    QuizModel? quizModel,
    List<QuestionQuizModel>? listQuestion,
    List<StudentModel>? listStudent,
    List<QuizAnswerModel?>? listAnswer,
  }) {
    return ViewQuizCubitState(
      status: status ?? this.status,
      quizModel: quizModel ?? this.quizModel,
      listQuestion: listQuestion ?? this.listQuestion,
      listStudent: listStudent ?? this.listStudent,
      listAnswer: listAnswer ?? this.listAnswer,
    );
  }

  @override
  List<Object> get props => [status, listAnswer, listAnswer.length, quizModel, listQuestion, listQuestion.length, listStudent, listStudent.length];
}

enum Status { initial, loading, success, error }
