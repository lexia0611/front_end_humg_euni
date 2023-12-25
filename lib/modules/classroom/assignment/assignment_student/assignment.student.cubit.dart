import 'dart:async';
import 'package:fe/model/class.model.dart';
import 'package:fe/provider/assignment.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'assignment.student.cubit.state.dart';

class AssignmentStudentCubit extends Cubit<AssignmentStudentCubitState> {
  final ClassModel classModel;

  AssignmentStudentCubit({
    required this.classModel,
  }) : super(const AssignmentStudentCubitState()) {
    getListAssignmentTeacher();
  }

  Future<void> getListAssignmentTeacher({int? status}) async {
    emit(state.copyWith(status: AssignmentStatus.loading));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString("username");
    var list = await AssignmentProvider.getList(classId: classModel.id ?? "", status: status);
    for (var element in list) {
      var assignment = await AssignmentProvider.getStudentFromAssigmentId(assignmentId: element.id ?? 0, username: username ?? "");
      element.assignmentStudentModel = assignment;
    }
    emit(state.copyWith(status: AssignmentStatus.success, listAssignment: list));
  }
}
