import 'package:assigment1/BodyText.dart';
import 'package:flutter/material.dart';
import 'BodyText.dart';

class TextControl extends StatelessWidget {
  final VoidCallback buttonPress;
  final int index;
  final List<String> texts;

  TextControl(
      {required this.buttonPress, required this.index, required this.texts});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BodyText(texts[index]),
        ElevatedButton(onPressed: buttonPress, child: Text('Change text'))
      ],
    );
  }
}
