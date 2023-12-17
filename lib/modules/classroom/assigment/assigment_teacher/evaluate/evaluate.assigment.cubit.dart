import 'package:fe/model/assignment.student.model.dart';
import 'package:fe/provider/assignment.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'evaluate.assigment.cubit.state.dart';

class EvaluateAssigmentCubit extends Cubit<EvaluateAssignmentCubitState> {
  final AssignmentStudentModel assigmentStudentModel;
  TextEditingController point = TextEditingController();

  EvaluateAssigmentCubit({
    required this.assigmentStudentModel,
  }) : super(EvaluateAssignmentCubitState(assignmentStudentModel: assigmentStudentModel)) {
    point = TextEditingController(text: (assigmentStudentModel.point != null) ? assigmentStudentModel.point.toString() : "");
  }


  changeInput() {
    emit(state.copyWith(showButton: true));
  }

  void sendPoint() async {
    assigmentStudentModel.point = int.tryParse(point.text);
    emit(state.copyWith(showButton: false, assignmentStudentModel: assigmentStudentModel));
    await AssignmentProvider.updateSendAssigment(assigmentStudentModel: assigmentStudentModel);
  }
}
