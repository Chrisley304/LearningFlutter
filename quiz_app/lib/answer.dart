import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final VoidCallback Handlerfunc;
  String answerText;

  // Constructor in short way
  Answer(this.Handlerfunc, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        child: Text(answerText),
        onPressed: Handlerfunc,
        color: Colors.blue,
      ),
    );
  }
}
