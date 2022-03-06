import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int finalScore;
  final VoidCallback resetQuiz;

  String get resultPhrase {
    var resultText = 'You did it\n';
    if (finalScore <= 8) {
      resultText += 'You are strange...';
    } else if (finalScore <= 12) {
      resultText += 'You are the dick';
    } else {
      resultText += 'You are the best in this';
    }
    return resultText;
  }

  Result(this.finalScore, this.resetQuiz);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          FlatButton(
            onPressed: resetQuiz,
            child: Text('Restart quiz!'),
            textColor: Colors.blue,
          )
        ],
      ),
    );
  }
}
