import 'dart:async';
import 'package:fe/model/class.model.dart';
import 'package:fe/provider/quiz.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'quiz.student.cubit.state.dart';

class QuizStudentCubit extends Cubit<QuizStudentCubitState> {
  final ClassModel classModel;

  QuizStudentCubit({
    required this.classModel,
  }) : super(const QuizStudentCubitState()) {
    getListQuizTeacher();
  }

  Future<void> getListQuizTeacher({int? status}) async {
    emit(state.copyWith(status: Status.loading));
    var list = await QuizProvider.getListForStudent(classId: classModel.id ?? "", status: status);
    emit(state.copyWith(status: Status.success, listQuizModel: list));
  }
}
