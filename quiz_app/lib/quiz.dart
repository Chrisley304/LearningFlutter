import 'package:flutter/material.dart';
import 'question.dart';
import 'answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>>? questions;
  final Function answerQuestions;
  final int index;

  Quiz(
      {required this.answerQuestions,
      required this.questions,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question((questions![index]['question'] as String)),
        // Creating in a dinamic way the Answers widgets, iterating in the list of answers:
        // Los '...' hacen que la lista se itere y se se ingrese al children los valores, no la lista como tal
        ...(questions![index]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(
              () => answerQuestions(answer['score']), answer['text'] as String);
        }).toList()
      ],
    );
  }
}
