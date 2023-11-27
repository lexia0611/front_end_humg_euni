import 'dart:async';
import 'package:fe/model/assigment.model.dart';
import 'package:fe/model/assigment.student.model.dart';
import 'package:fe/model/class.model.dart';
import 'package:fe/model/sinh.vien.model.dart';
import 'package:fe/provider/assigment.provider.dart';
import 'package:fe/provider/classroom.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'view.assigment.cubit.state.dart';

class ViewAssigmentCubit extends Cubit<ViewAssigmentCubitState> {
  final ClassModel classModel;
  final AssigmentModel assigmentModel;

  ViewAssigmentCubit({
    required this.classModel,
    required this.assigmentModel,
  }) : super(ViewAssigmentCubitState(assigmentModel: assigmentModel)) {
    getList();
  }

  Future<void> getList({int? status}) async {
    emit(state.copyWith(status: Status.loading));
    List<AssigmentStudentModel> listAssigmentStudentModel = [];
    List<StudentModel> listStudent = await ClassroomProvider.getListStudent(classModel.id ?? "");
    listAssigmentStudentModel = List<AssigmentStudentModel>.generate(
      listStudent.length,
      (int index) => AssigmentStudentModel(
        assigmentId: assigmentModel.id,
        username: listStudent[index].ma_sinh_vien,
        student: listStudent[index],
      ),
    );
    List<AssigmentStudentModel> listAssigmentStudentModelNew = [];
    for (var element in listAssigmentStudentModel) {
      var assigmentSt = await AssigmentProvider.getStudentFromAssigmentId(assigmentId: element.assigmentId ?? 0, username: element.username ?? "");
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
