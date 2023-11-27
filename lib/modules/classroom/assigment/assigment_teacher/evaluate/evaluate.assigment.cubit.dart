import 'package:fe/model/assigment.student.model.dart';
import 'package:fe/provider/assigment.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'evaluate.assigment.cubit.state.dart';

class EvaluateAssigmentCubit extends Cubit<EvaluateAssigmentCubitState> {
  final AssigmentStudentModel assigmentStudentModel;
  TextEditingController point = TextEditingController();

  EvaluateAssigmentCubit({
    required this.assigmentStudentModel,
  }) : super(EvaluateAssigmentCubitState(assigmentStudentModel: assigmentStudentModel)) {
    point = TextEditingController(text: (assigmentStudentModel.point != null) ? assigmentStudentModel.point.toString() : "");
  }


  changeInput() {
    emit(state.copyWith(showButton: true));
  }

  void sendPoint() async {
    assigmentStudentModel.point = int.tryParse(point.text);
    emit(state.copyWith(showButton: false, assigmentStudentModel: assigmentStudentModel));
    await AssigmentProvider.updateSendAssigment(assigmentStudentModel: assigmentStudentModel);
  }
}
