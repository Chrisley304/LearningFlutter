import 'package:flutter/material.dart';
import 'package:quiz_app/result.dart';
import 'question.dart';
import 'answer.dart';
import 'quiz.dart';
import 'result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyFuckingAppState();
  }
}

class _MyFuckingAppState extends State<MyApp> {
  var _questionIndex = 0;
  var _finalScore = 0;
  static const _questions = [
    {
      'question': 'What\'s your favorite color?',
      'answers': [
        {'text': 'Blue', 'score': 5},
        {'text': 'Purple', 'score': 10},
        {'text': 'Black', 'score': 1},
        {'text': 'Yellow', 'score': 3}
      ]
    },
    {
      'question': 'Which TV show is your favorite?',
      'answers': [
        {'text': 'Breking Bad', 'score': 10},
        {'text': 'Luis Miguel', 'score': 3},
        {'text': 'Rick & Morty', 'score': 8},
        {'text': 'The Mandalorian', 'score': 9}
      ]
    },
    {
      'question': 'What\'s your favorite videogame?',
      'answers': [
        {'text': 'Psychonauts', 'score': 5},
        {'text': 'Red Dead Redemption 2', 'score': 10},
        {'text': 'Mario Galaxy', 'score': 1},
        {'text': 'GTA V', 'score': 3}
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('My first app!')),
        body: _questionIndex < _questions.length
            ? Quiz(
                answerQuestions: _answerQuestion,
                questions: _questions,
                index: _questionIndex)
            : Result(_finalScore, _resetQuiz),
      ),
    );
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _finalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _finalScore += score;

    if (_questionIndex < _questions.length) {
      setState(() {
        _questionIndex++;
      });
    }
  }
}
