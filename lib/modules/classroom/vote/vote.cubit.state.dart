import 'package:equatable/equatable.dart';
import 'package:fe/model/vote.model.dart';
import 'package:fe/model/vote.option.model.dart';

class VoteCubitState extends Equatable {
  final Status status;
  final int? selected;
  final VoteModel? voteModel;
  final List<VoteOptionModel> listVoteOptionModel;
  final int countStudent;
  final bool isTeacher;
  const VoteCubitState({
    this.isTeacher=false,
    this.status = Status.initial,
    this.voteModel,
    this.selected,
    this.listVoteOptionModel = const [],
    this.countStudent = 0,
  });

  VoteCubitState copyWith({
    bool? isTeacher,
    Status? status,
    VoteModel? voteModel,
    int? selected,
    List<VoteOptionModel>? listVoteOptionModel,
    int? countStudent,
  }) {
    return VoteCubitState(
      isTeacher: isTeacher ?? this.isTeacher,
      status: status ?? this.status,
      selected: selected ?? this.selected,
      voteModel: voteModel ?? this.voteModel,
      listVoteOptionModel: listVoteOptionModel ?? this.listVoteOptionModel,
      countStudent: countStudent ?? this.countStudent,
    );
  }

  @override
  List<Object?> get props => [status, listVoteOptionModel, listVoteOptionModel.length, voteModel, selected, countStudent, isTeacher];
}

enum Status { initial, loading, success, error }
