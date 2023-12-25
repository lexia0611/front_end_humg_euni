import 'dart:async';
import 'package:fe/model/class.model.dart';
import 'package:fe/provider/quiz.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'quiz.teacher.cubit.state.dart';

class QuizTeacherCubit extends Cubit<QuizTeacherCubitState> {
  final ClassModel classModel;

  QuizTeacherCubit({
    required this.classModel,
  }) : super(const QuizTeacherCubitState()) {
    getListQuizTeacher();
  }

  Future<void> getListQuizTeacher({int? status}) async {
    emit(state.copyWith(status: AssignmentStatus.loading));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? roles = prefs.getString("roles");
    var isGV = true;
    if (roles == "SINHVIEN") {
      isGV = false;
    }
    var list = await QuizProvider.getList(classId: classModel.id ?? "", status: status);
    emit(state.copyWith(status: AssignmentStatus.success, listQuizModel: list, isGV: isGV));
  }
}
