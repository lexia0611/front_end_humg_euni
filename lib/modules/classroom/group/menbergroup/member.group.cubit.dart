import 'package:fe/model/class.model.dart';
import 'package:fe/model/group.member.dart';
import 'package:fe/model/sinh.vien.model.dart';
import 'package:fe/provider/classroom.provider.dart';
import 'package:fe/provider/group.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'member.group.cubit.state.dart';

class MemberGroupCubit extends Cubit<MemberGroupCubitState> {
  final ClassModel classModel;
  final List<GroupMemberModel> listGroupMember;

  MemberGroupCubit({
    required this.classModel,
    required this.listGroupMember,
  }) : super(const MemberGroupCubitState()) {
    init();
  }
  init() async {
    emit(state.copyWith(status: MemberGroupStatus.loading));
    var listStudentClass = await ClassroomProvider.getListStudent(classModel.id ?? "");
    for (var element in listGroupMember) {
      if (listStudentClass.contains(element.student)) {
        listStudentClass.remove(element.student);
      }
    }
    emit(state.copyWith(status: MemberGroupStatus.success, listStudentClass: listStudentClass, listGroupMemberModel: listGroupMember));
  }

  updateListStudent(List<GroupMemberModel> listStudent) {
    emit(state.copyWith(listGroupMemberModel: listStudent));
  }

  removeListStudent(GroupMemberModel studentModel) async {
    emit(state.copyWith(status: MemberGroupStatus.loading));
    state.listGroupMemberModel.remove(studentModel);
    await GroupProvider.deleteMemberGroup(studentModel.id ?? 0);
    emit(state.copyWith(status: MemberGroupStatus.success, listGroupMemberModel: state.listGroupMemberModel));
  }

  updateListStudentClass(List<StudentModel> listStudentClass) {
    emit(state.copyWith(listStudentClass: listStudentClass));
  }

  void addListStudentClass(StudentModel element) {
    state.listStudentClass.add(element);
    emit(state.copyWith(listStudentClass: state.listStudentClass));
  }
}
