import 'package:fe/model/assigment.model.dart';
import 'package:fe/provider/assigment.provider.dart';
import 'package:fe/provider/file.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'view.assigment.student.cubit.state.dart';

class ViewAssigmentStudentCubit extends Cubit<ViewAssigmentStudentCubitState> {
  final AssigmentModel assigmentModel;

  ViewAssigmentStudentCubit({
    required this.assigmentModel,
  }) : super(ViewAssigmentStudentCubitState(assigmentModel: assigmentModel)) {}

  void uploadFile() async {
    var fileName = await handleUploadFileAll();
    emit(state.copyWith(fileName: fileName));
  }

  void sendAssigment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString("username");
    // updateSendAssigment
    if (state.assigmentModel.assignmentStudentModel == null) {
      var response = await AssigmentProvider.sendAssigment(assigmentId: state.assigmentModel.id ?? 0, username: username ?? "", fileName: state.fileName);
      if (response != null) {
        state.assigmentModel.assignmentStudentModel = response;
      }
    } else {
      state.assigmentModel.assignmentStudentModel!.fileName = state.fileName;
      await AssigmentProvider.updateSendAssigment(assigmentStudentModel: state.assigmentModel.assignmentStudentModel!);
    }
    emit(state.copyWith(fileName: "", assigmentModel: state.assigmentModel));
  }
}