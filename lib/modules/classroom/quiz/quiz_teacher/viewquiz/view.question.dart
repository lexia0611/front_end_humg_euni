import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'view.quiz.cubit.dart';
import 'view.quiz.cubit.state.dart';

class ViewQuestion extends StatefulWidget {
  const ViewQuestion({super.key});

  @override
  State<ViewQuestion> createState() => _ViewQuestionState();
}

class _ViewQuestionState extends State<ViewQuestion> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Ensure that the AutomaticKeepAliveClientMixin is correctly implemented.
    return BlocBuilder<ViewQuizCubit, ViewQuizCubitState>(
      builder: (context, state) {
        return AnimationList(
          children: [
            for (var i = 0; i < state.listQuestion.length; i++)
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Question ${i + 1}: ${state.listQuestion[i].question}",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "     Option 1: ${state.listQuestion[i].option1}",
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "     Option 2: ${state.listQuestion[i].option2}",
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "     Option 3: ${state.listQuestion[i].option3}",
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "     Option 4: ${state.listQuestion[i].option4}",
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              )
          ],
        );
      },
    );
  }
}
