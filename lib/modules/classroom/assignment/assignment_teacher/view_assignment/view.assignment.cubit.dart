import 'dart:async';
import 'package:fe/model/assignment.model.dart';
import 'package:fe/model/assignment.student.model.dart';
import 'package:fe/model/class.model.dart';
import 'package:fe/model/sinh.vien.model.dart';
import 'package:fe/provider/assignment.provider.dart';
import 'package:fe/provider/classroom.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'view.assignment.cubit.state.dart';

class ViewAssignmentCubit extends Cubit<ViewAssignmentCubitState> {
  final ClassModel classModel;
  final AssignmentModel assignmentModel;

  ViewAssignmentCubit({
    required this.classModel,
    required this.assignmentModel,
  }) : super(ViewAssignmentCubitState(assignmentModel: assignmentModel)) {
    getList();
  }

  Future<void> getList({int? status}) async {
    emit(state.copyWith(status: Status.loading));
    List<AssignmentStudentModel> listAssignmentStudentModel = [];
    List<StudentModel> listStudent = await ClassroomProvider.getListStudent(classModel.id ?? "");
    listAssignmentStudentModel = List<AssignmentStudentModel>.generate(
      listStudent.length,
      (int index) => AssignmentStudentModel(
        assignmentId: assignmentModel.id,
        username: listStudent[index].ma_sinh_vien,
        student: listStudent[index],
      ),
    );
    List<AssignmentStudentModel> listAssignmentStudentModelNew = [];
    for (var element in listAssignmentStudentModel) {
      var assignmentSt = await AssignmentProvider.getStudentFromAssigmentId(assignmentId: element.assignmentId ?? 0, username: element.username ?? "");
      if (assignmentSt != null) {
        var student = element.student;
        element = assignmentSt;
        element.student = student;
      }
      listAssignmentStudentModelNew.add(element);
    }
    emit(state.copyWith(status: Status.success, listAssignmentStudentModel: listAssignmentStudentModelNew));
  }
}
