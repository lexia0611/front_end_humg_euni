import 'package:fe/model/class.model.dart';
import 'package:fe/model/question.quiz.model.dart';
import 'package:fe/model/quiz.model.dart';
import 'package:fe/provider/quiz.provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'update.quiz.cubit.state.dart';

class UpdateQuizCubit extends Cubit<UpdateQuizCubitState> {
  final QuizModel? quizModel;
  final ClassModel classModel;
  final TextEditingController title = TextEditingController();
  String? datStart;
  String? timeStart;
  String? datEnd;
  String? timeEnd;

  UpdateQuizCubit({
    this.quizModel,
    required this.classModel,
  }) : super(UpdateQuizCubitState(quizModel: quizModel ?? QuizModel(classId: classModel.id, status: 1))) {
    setData();
  }

  setData() async {
    if (quizModel != null) {
      title.text = quizModel?.title ?? "";
      datStart = DateFormat('dd-MM-yyyy').format(DateTime.parse(quizModel?.startTime ?? "").toLocal());
      timeStart = DateFormat('HH:mm').format(DateTime.parse(quizModel?.startTime ?? "").toLocal());
      datEnd = DateFormat('dd-MM-yyyy').format(DateTime.parse(quizModel?.endTime ?? "").toLocal());
      timeEnd = DateFormat('HH:mm').format(DateTime.parse(quizModel?.endTime ?? "").toLocal());
      var listQuestion = await QuizProvider.getListQuestion(idQuiz: quizModel?.id ?? 0);
      emit(state.copyWith(listQuestion: listQuestion));
    }
  }

  updateStartTime(String startTime) {
    if (startTime != "") {
      state.quizModel.startTime = startTime;
    } else {
      state.quizModel.startTime = null;
    }
    emit(state.copyWith(quizModel: state.quizModel));
  }

  updateEndTime(String endTime) {
    if (endTime != "") {
      state.quizModel.endTime = endTime;
    } else {
      state.quizModel.endTime = null;
    }
    emit(state.copyWith(quizModel: state.quizModel));
  }

  void send() {
    state.quizModel.title = title.text;
    // print(state.quizModel.toMap());
    // for (var element in state.listQuestion) {
    //   print(element.toMap());
    // }
    if (state.quizModel.title != null && state.quizModel.endTime != null && state.quizModel.startTime != null) {
      if (quizModel == null) {
        create();
      } else {
        update();
      }
    } else {
      emit(state.copyWith(status: Status.notNull));
    }
  }

  void update() async {
    emit(state.copyWith(status: Status.loading));
    await QuizProvider.update(state.quizModel, state.listQuestion);
    emit(state.copyWith(status: Status.successEdit, quizModel: state.quizModel));
  }

  void create() async {
    emit(state.copyWith(status: Status.loading));
    await QuizProvider.create(state.quizModel, state.listQuestion);
    emit(state.copyWith(status: Status.success));
  }

  void addQuestion() {
    var listNew = List<QuestionQuizModel>.generate(state.listQuestion.length, (index) => state.listQuestion[index]);
    listNew.add(QuestionQuizModel());
    emit(state.copyWith(listQuestion: listNew));
  }

  void updateQuestion(QuestionQuizModel questionQuizModel, int index) async {
    var listNew = List<QuestionQuizModel>.generate(state.listQuestion.length, (index) => state.listQuestion[index]);
    listNew[index] = questionQuizModel;
    if (questionQuizModel.id != null) {
      await QuizProvider.deleteQuestion(id: questionQuizModel.id);
    }
    emit(state.copyWith(listQuestion: listNew));
  }

  void removeQuestion(int index, QuestionQuizModel questionQuizModel) async {
    var listNew = List<QuestionQuizModel>.generate(state.listQuestion.length, (index) => state.listQuestion[index]);
    listNew.removeAt(index);
    await QuizProvider.deleteQuestion(id: questionQuizModel.id ?? 0);
    emit(state.copyWith(listQuestion: listNew));
  }

  void updateStatus(int? value) {
    emit(state.copyWith(status: Status.initial));
    var quizModelNew = state.quizModel.copyWith(status: value);
    emit(state.copyWith(status: Status.successChangeStatus, quizModel: quizModelNew));
  }
}
