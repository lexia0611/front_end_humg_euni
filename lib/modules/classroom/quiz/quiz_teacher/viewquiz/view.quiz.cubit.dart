import 'package:fe/app/constant/convert.dart';
import 'package:fe/model/quiz.answer.model.dart';
import 'package:fe/model/quiz.model.dart';
import 'package:fe/model/sinh.vien.model.dart';
import 'package:fe/provider/classroom.provider.dart';
import 'package:fe/provider/quiz.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'view.quiz.cubit.state.dart';

class ViewQuizCubit extends Cubit<ViewQuizCubitState> {
  final QuizModel quizModel;
  ViewQuizCubit({
    required this.quizModel,
  }) : super(ViewQuizCubitState(quizModel: quizModel)) {
    getDate();
  }

  Future<void> getDate({int? status}) async {
    emit(state.copyWith(status: Status.loading));
    var listQuestion = await QuizProvider.getListQuestion(idQuiz: quizModel.id ?? 0);
    List<QuizAnswerModel?> listAnswer = [];
    List<StudentModel> listStudent = await ClassroomProvider.getListStudent(quizModel.classId ?? "");
    for (var element in listStudent) {
      var answer = await QuizProvider.getAnswer(idQuiz: quizModel.id ?? 0, username: element.ma_sinh_vien ?? "");
      if (answer != null) {
        var answerNew = answer.copyWith(answerConvert: stringToListInt(answer.answer ?? ""));
        listAnswer.add(answerNew);
      } else {
        listAnswer.add(null);
      }
    }
    emit(state.copyWith(status: Status.success, listQuestion: listQuestion, listAnswer: listAnswer, listStudent: listStudent));
  }
}
