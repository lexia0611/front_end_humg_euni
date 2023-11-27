import 'dart:async';
import 'package:fe/app/constant/convert.dart';
import 'package:fe/model/quiz.anser.model.dart';
import 'package:fe/model/quiz.model.dart';
import 'package:fe/provider/quiz.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'anser.quiz.cubit.state.dart';

class AnserQuizCubit extends Cubit<AnserQuizCubitState> {
  final QuizModel quizModel;
  late List<int?> listAnser;
  AnserQuizCubit({
    required this.quizModel,
  }) : super(AnserQuizCubitState(quizModel: quizModel)) {
    getListQuestion();
  }

  Future<void> getListQuestion({int? status}) async {
    emit(state.copyWith(status: Status.loading));
    var list = await QuizProvider.getListQuestion(idQuiz: quizModel.id ?? 0);
    if (quizModel.quizAnserModel == null) {
      listAnser = List<int?>.generate(list.length, ((index) => null));
    } else {
      listAnser = stringToListInt(quizModel.quizAnserModel?.anser ?? "");
    }
    emit(state.copyWith(status: Status.initial, listQuestion: list, listAnser: listAnser));
  }

  void updateAnser(int index, int? value) {
    emit(state.copyWith(status: Status.loading));
    listAnser[index] = value;
    emit(state.copyWith(status: Status.initial, listAnser: listAnser));
  }

  void sendAnser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString("username");
    var listAnserConvert = listIntToString(state.listAnser);
    await QuizProvider.sendAnser(idQuiz: quizModel.id ?? 0, username: username ?? '', anser: listAnserConvert);
    updateAnserModel(QuizAnserModel(quizId: quizModel.id ?? 0, username: username, anser: listAnserConvert));
    emit(state.copyWith(status: Status.success));
  }

  void updateAnserModel(QuizAnserModel quizAnserModel) {
    emit(state.copyWith(status: Status.loading));
    quizModel.quizAnserModel = quizAnserModel;
    emit(state.copyWith(quizModel: quizModel, status: Status.initial));
  }
}
