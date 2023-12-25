import 'package:fe/model/assignment.student.model.dart';
import 'package:fe/provider/assignment.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'evaluate.assignment.cubit.state.dart';

class EvaluateAssignmentCubit extends Cubit<EvaluateAssignmentCubitState> {
  final AssignmentStudentModel assignmentStudentModel;
  TextEditingController point = TextEditingController();

  EvaluateAssignmentCubit({
    required this.assignmentStudentModel,
  }) : super(EvaluateAssignmentCubitState(assignmentStudentModel: assignmentStudentModel)) {
    point = TextEditingController(text: (assignmentStudentModel.point != null) ? assignmentStudentModel.point.toString() : "");
  }


  changeInput() {
    emit(state.copyWith(showButton: true));
  }

  void sendPoint() async {
    assignmentStudentModel.point = int.tryParse(point.text);
    emit(state.copyWith(showButton: false, assignmentStudentModel: assignmentStudentModel));
    await AssignmentProvider.updateSendAssignment(assignmentStudentModel: assignmentStudentModel);
  }
}
