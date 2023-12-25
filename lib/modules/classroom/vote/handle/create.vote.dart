// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, prefer_typing_uninitialized_variables
import 'package:fe/app/widgets/textfield.dart';
import 'package:fe/model/class.model.dart';
import 'package:fe/model/vote.model.dart';
import 'package:fe/provider/vote.provider.dart';
import 'package:flutter/material.dart';

class CreateVote extends StatefulWidget {
  final ClassModel classModel;
  const CreateVote({super.key, required this.classModel});

  @override
  State<CreateVote> createState() => _CreateVoteState();
}

class _CreateVoteState extends State<CreateVote> {
  VoteModel voteModel = VoteModel(status: 1);
  TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Create vote", style: TextStyle(fontSize: 20)),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 150,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFieldWidget(
                title: 'Title',
                controller: name,
                // maxLine: 1,
              ),
            ],
          ),
        ),
      ),
      actions: [
        Container(
          width: 70,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Center(
              child: Text(
                "Cancel",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ),
        Container(
          width: 70,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            onTap: () async {
              if (name.text != "") {
                voteModel.classId = widget.classModel.id ??"";
                voteModel.title = name.text;
                await VoteProvider.createVote(voteModel);
                Navigator.pop(context, true);
              }
            },
            child: const Center(
              child: Text(
                "Save",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}
