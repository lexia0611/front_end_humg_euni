import 'package:fe/model/class.model.dart';
import 'package:fe/model/vote.option.model.dart';
import 'package:fe/provider/classroom.provider.dart';
import 'package:fe/provider/vote.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'vote.cubit.state.dart';

class VoteCubit extends Cubit<VoteCubitState> {
  final ClassModel classModel;

  VoteCubit({
    required this.classModel,
  }) : super(const VoteCubitState()) {
    getData();
    getRole();
  }

  void getData() async {
    emit(state.copyWith(status: Status.loading));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString("username") ?? "";
    int? selected;
    var listStudentClass = await ClassroomProvider.getListStudent(classModel.id ?? "");
    int countStudent = listStudentClass.length;
    var voteModel = await VoteProvider.getVoteModel(classModel.id ?? "");
    List<VoteOptionModel> listOption = [];
    if (voteModel != null) {
      listOption = await VoteProvider.getListOptionVote(voteId: voteModel.id ?? 0);
      if (listOption.isNotEmpty) {
        for (var i = 0; i < listOption.length; i++) {
          var data = listOption[i].data ?? "";
          if (data.contains(username)) {
            selected = i;
          }
        }
      }
    }
    emit(state.copyWith(voteModel: voteModel, status: Status.success, listVoteOptionModel: listOption, selected: selected, countStudent: countStudent));
  }

  void doneVote() {
    getData();
  }

  void updateSelect(int index, int? value) async {
    getRole();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString("username") ?? "";
    var voteOptionModelNew = state.listVoteOptionModel[index];
    voteOptionModelNew.data ??= '';

    if (state.selected != null) {
      var voteOptionModelOld = state.listVoteOptionModel[state.selected ?? 0];
      if (voteOptionModelOld.data != null && voteOptionModelOld.data != "") {
        if (voteOptionModelOld.data!.contains(username)) {
          var string = voteOptionModelOld.data?.replaceAll(',$username', "");
          voteOptionModelOld.data = string;
          await VoteProvider.updateVoteOption(voteOptionModelOld);
        }
      }
    }
    voteOptionModelNew.data = "${voteOptionModelNew.data!},$username";
    await VoteProvider.updateVoteOption(voteOptionModelNew);
    getData();
  }

  Future<void> getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? roles = prefs.getString("roles");
    var isGV = true;
    if (roles == "SINHVIEN") {
      isGV = false;
    }
    emit(state.copyWith(isTeacher: isGV));
  }
}
