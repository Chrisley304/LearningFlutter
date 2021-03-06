import 'package:flutter/material.dart';

class BodyText extends StatelessWidget {
  final String text;

  BodyText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
