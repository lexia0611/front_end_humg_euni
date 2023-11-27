import 'dart:async';
import 'package:fe/model/class.model.dart';
import 'package:fe/provider/assigment.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'assgment.techer.cubit.state.dart';

class AssigmentTeacherCubit extends Cubit<AssigmentTeacherCubitState> {
  final ClassModel classModel;

  AssigmentTeacherCubit({
    required this.classModel,
  }) : super(const AssigmentTeacherCubitState()) {
    getListAssigmentTeacher();
  }

  Future<void> getListAssigmentTeacher({int? status}) async {
    emit(state.copyWith(status: AssigmentStatus.loading));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? roles = prefs.getString("roles");
    var isGV = true;
    if (roles == "SINHVIEN") {
      isGV = false;
    }
    var list = await AssigmentProvider.getList(classId: classModel.id ?? "", status: status);
    emit(state.copyWith(status: AssigmentStatus.success, listAssigment: list, isGV: isGV));
  }
}
