import 'package:fe/model/assignment.model.dart';
import 'package:fe/provider/assignment.provider.dart';
import 'package:fe/provider/file.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'view.assignment.student.cubit.state.dart';

class ViewAssignmentStudentCubit extends Cubit<ViewAssignmentStudentCubitState> {
  final AssignmentModel assignmentModel;

  ViewAssignmentStudentCubit({
    required this.assignmentModel,
  }) : super(ViewAssignmentStudentCubitState(assignmentModel: assignmentModel)) {}

  void uploadFile() async {
    var fileName = await handleUploadFileAll();
    emit(state.copyWith(fileName: fileName));
  }

  void sendAssignment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString("username");
    // updateSendAssignment
    if (state.assignmentModel.assignmentStudentModel == null) {
      var response = await AssignmentProvider.sendAssignment(assignmentId: state.assignmentModel.id ?? 0, username: username ?? "", fileName: state.fileName);
      if (response != null) {
        state.assignmentModel.assignmentStudentModel = response;
      }
    } else {
      state.assignmentModel.assignmentStudentModel!.fileName = state.fileName;
      await AssignmentProvider.updateSendAssignment(assignmentStudentModel: state.assignmentModel.assignmentStudentModel!);
    }
    emit(state.copyWith(fileName: "", assignmentModel: state.assignmentModel));
  }
}
