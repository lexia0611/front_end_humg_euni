import 'dart:async';
import 'package:fe/model/assignment.model.dart';
import 'package:fe/model/assignment.student.model.dart';
import 'package:fe/model/class.model.dart';
import 'package:fe/model/sinh.vien.model.dart';
import 'package:fe/provider/assignment.provider.dart';
import 'package:fe/provider/classroom.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'view.assigment.cubit.state.dart';

class ViewAssignmentCubit extends Cubit<ViewAssigmentCubitState> {
  final ClassModel classModel;
  final AssignmentModel assignmentModel;

  ViewAssignmentCubit({
    required this.classModel,
    required this.assignmentModel,
  }) : super(ViewAssigmentCubitState(assigmentModel: assignmentModel)) {
    getList();
  }

  Future<void> getList({int? status}) async {
    emit(state.copyWith(status: Status.loading));
    List<AssignmentStudentModel> listAssigmentStudentModel = [];
    List<StudentModel> listStudent = await ClassroomProvider.getListStudent(classModel.id ?? "");
    listAssigmentStudentModel = List<AssignmentStudentModel>.generate(
      listStudent.length,
      (int index) => AssignmentStudentModel(
        assigmentId: assignmentModel.id,
        username: listStudent[index].ma_sinh_vien,
        student: listStudent[index],
      ),
    );
    List<AssignmentStudentModel> listAssigmentStudentModelNew = [];
    for (var element in listAssigmentStudentModel) {
      var assigmentSt = await AssignmentProvider.getStudentFromAssigmentId(assigmentId: element.assigmentId ?? 0, username: element.username ?? "");
      if (assigmentSt != null) {
        var student = element.student;
        element = assigmentSt;
        element.student = student;
      }
      listAssigmentStudentModelNew.add(element);
    }
    emit(state.copyWith(status: Status.success, listAssigmentStudentModel: listAssigmentStudentModelNew));
  }
}
