import 'dart:async';
import 'package:fe/model/class.model.dart';
import 'package:fe/model/group.model.dart';
import 'package:fe/provider/group.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'group.cubit.state.dart';

class GroupCubit extends Cubit<GroupCubitState> {
  final ClassModel classModel;

  GroupCubit({
    required this.classModel,
  }) : super(const GroupCubitState()) {
    getListGroup();
  }

  Future<void> getListGroup({int? status}) async {
    emit(state.copyWith(status: GroupStatus.loading));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? roles = prefs.getString("roles");
    var isGV = true;
    if (roles == "SINHVIEN") {
      isGV = false;
    }
    List<GroupModel> listGroup = [];
    if (isGV) {
      listGroup = await GroupProvider.getList(classId: classModel.id ?? "");
      for (var element in listGroup) {
        element.listGroupMemberModel = await GroupProvider.getListStudentForGroup(groupId: element.id ?? 0, classId: classModel.id ?? "");
      }
    } else {
      String? username = prefs.getString("username");
      listGroup = await GroupProvider.getListForStudent(username: username ?? "");
      for (var element in listGroup) {
        element.listGroupMemberModel = await GroupProvider.getListStudentForGroup(groupId: element.id ?? 0, classId: classModel.id ?? "");
      }
    }
    emit(state.copyWith(status: GroupStatus.success, listGroup: listGroup, isGV: isGV));
  }
}
