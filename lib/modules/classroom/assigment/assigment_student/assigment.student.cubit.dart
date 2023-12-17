import 'dart:async';
import 'package:fe/model/class.model.dart';
import 'package:fe/provider/assignment.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'assigment.student.cubit.state.dart';

class AssigmentStudentCubit extends Cubit<AssigmentStudentCubitState> {
  final ClassModel classModel;

  AssigmentStudentCubit({
    required this.classModel,
  }) : super(const AssigmentStudentCubitState()) {
    getListAssigmentTeacher();
  }

  Future<void> getListAssigmentTeacher({int? status}) async {
    emit(state.copyWith(status: AssigmentStatus.loading));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString("username");
    var list = await AssignmentProvider.getList(classId: classModel.id ?? "", status: status);
    for (var element in list) {
      var assigment = await AssignmentProvider.getStudentFromAssigmentId(assigmentId: element.id ?? 0, username: username ?? "");
      element.assignmentStudentModel = assigment;
    }
    emit(state.copyWith(status: AssigmentStatus.success, listAssigment: list));
  }
}
