import 'dart:async';
import 'package:fe/app/constant/convert.dart';
import 'package:fe/model/quiz.answer.model.dart';
import 'package:fe/model/quiz.model.dart';
import 'package:fe/provider/quiz.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'answer.quiz.cubit.state.dart';

class AnswerQuizCubit extends Cubit<AnswerQuizCubitState> {
  final QuizModel quizModel;
  late List<int?> listAnswer;
  AnswerQuizCubit({
    required this.quizModel,
  }) : super(AnswerQuizCubitState(quizModel: quizModel)) {
    getListQuestion();
  }

  Future<void> getListQuestion({int? status}) async {
    emit(state.copyWith(status: Status.loading));
    var list = await QuizProvider.getListQuestion(idQuiz: quizModel.id ?? 0);
    if (quizModel.quizAnswerModel == null) {
      listAnswer = List<int?>.generate(list.length, ((index) => null));
    } else {
      listAnswer = stringToListInt(quizModel.quizAnswerModel?.answer ?? "");
    }
    emit(state.copyWith(status: Status.initial, listQuestion: list, listAnswer: listAnswer));
  }

  void updateAnswer(int index, int? value) {
    emit(state.copyWith(status: Status.loading));
    listAnswer[index] = value;
    emit(state.copyWith(status: Status.initial, listAnswer: listAnswer));
  }

  void sendAnswer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString("username");
    var listAnswerConvert = listIntToString(state.listAnswer);
    await QuizProvider.sendAnswer(idQuiz: quizModel.id ?? 0, username: username ?? '', anser: listAnswerConvert);
    updateAnswerModel(QuizAnswerModel(quizId: quizModel.id ?? 0, username: username, answer: listAnswerConvert));
    emit(state.copyWith(status: Status.success));
  }

  void updateAnswerModel(QuizAnswerModel quizAnswerModel) {
    emit(state.copyWith(status: Status.loading));
    quizModel.quizAnswerModel = quizAnswerModel;
    emit(state.copyWith(quizModel: quizModel, status: Status.initial));
  }
}
