import 'dart:async';
import 'package:fe/model/class.model.dart';
import 'package:fe/provider/assignment.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'assignment.teacher.cubit.state.dart';

class AssignmentTeacherCubit extends Cubit<AssignmentTeacherCubitState> {
  final ClassModel classModel;

  AssignmentTeacherCubit({
    required this.classModel,
  }) : super(const AssignmentTeacherCubitState()) {
    getListAssignmentTeacher();
  }

  Future<void> getListAssignmentTeacher({int? status}) async {
    emit(state.copyWith(status: AssignmentStatus.loading));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? roles = prefs.getString("roles");
    var isGV = true;
    if (roles == "SINHVIEN") {
      isGV = false;
    }
    var list = await AssignmentProvider.getList(classId: classModel.id ?? "", status: status);
    emit(state.copyWith(status: AssignmentStatus.success, listAssignment: list, isGV: isGV));
  }
}
