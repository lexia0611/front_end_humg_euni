import 'package:dotted_border/dotted_border.dart';
import 'package:fe/app/widgets/button.not.click.multi.dart';
import 'package:fe/model/class.model.dart';
import 'package:fe/provider/vote.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'handle/create.vote.dart';
import 'handle/create.vote.option.dart';
import 'vote.cubit.dart';
import 'vote.cubit.state.dart';

class VotePage extends StatelessWidget {
  final ClassModel classModel;
  const VotePage({super.key, required this.classModel});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VoteCubit, VoteCubitState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.status == Status.loading) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.blue,
          ));
        }
        return Scaffold(
          body: (state.voteModel == null)
              ? const Center(
                  child: Text("No pool available at this time !"),
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.voteModel?.title ?? "",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        for (var index = 0;
                            index < state.listVoteOptionModel.length;
                            index++)
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                    "${state.listVoteOptionModel[index].count ?? 0} /${state.countStudent} "),
                              ),
                              Expanded(
                                flex: 7,
                                child: ListTile(
                                  title: Text(
                                      state.listVoteOptionModel[index].title ??
                                          ""),
                                  leading: Radio<int>(
                                    value: index,
                                    groupValue: state.selected,
                                    onChanged: (int? value) {
                                      context
                                          .read<VoteCubit>()
                                          .updateSelect(index, value);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 15),
                        Container(
                            child: (state.isTeacher == true)
                                ? DottedBorder(
                                    radius: const Radius.circular(15),
                                    child: ButtonNotClickMulti(
                                      onTap: () async {
                                        var response = await showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return CreateVoteOption(
                                                  voteModel: state.voteModel!);
                                            });
                                        if (response != null &&
                                            response == true) {
                                          context.read<VoteCubit>().getData();
                                        }
                                      },
                                      child: const SizedBox(
                                        height: 30,
                                        child: Center(
                                          child: Icon(Icons.add),
                                        ),
                                      ),
                                    ),
                                  )
                                : null),
                        const SizedBox(height: 15),
                        Center(
                            child: (state.isTeacher == true)
                                ? ButtonNotClickMulti(
                                    onTap: () async {
                                      var status = 0;
                                      var data = state.voteModel!
                                          .copyWith(status: status);
                                      await VoteProvider.updateVote(data);
                                      context.read<VoteCubit>().doneVote();
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color.fromARGB(
                                                    255, 0, 0, 0)
                                                .withOpacity(0.25),
                                            spreadRadius: 1,
                                            blurRadius: 4,
                                            offset: const Offset(2,
                                                2), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: const Center(
                                          child: Text(
                                        "Done",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      )),
                                    ))
                                : null)
                      ],
                    ),
                  ),
                ),
          floatingActionButton: (state.voteModel == null && state.isTeacher)
              ? Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.blue),
                  child: InkWell(
                    onTap: () async {
                      //
                      var response = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CreateVote(classModel: classModel);
                          });
                      if (response != null && response == true) {
                        context.read<VoteCubit>().getData();
                      }
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                )
              : null,
        );
      },
    );
  }
}
