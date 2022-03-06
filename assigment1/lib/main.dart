import 'package:flutter/material.dart';
import 'TextControl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _arrayIndex = 0;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const examples_texts = [
      "Hi!",
      "This is",
      "My assigment 1!",
      "My name is Christian",
      "Nice to meet you!!",
      "and that\'s all haha...",
      "Stop touching the button pls",
      "Seriously that\'s all",
      "STOP TOUCHING THE BUTTON"
    ];

    return MaterialApp(
      title: 'Assigment 1',
      home: Scaffold(
          appBar: AppBar(title: Text('Assigment 1')),
          body: Center(
              child: _arrayIndex < examples_texts.length
                  ? TextControl(
                      buttonPress: OnPress,
                      index: _arrayIndex,
                      texts: examples_texts)
                  : const Text("I\'m done >:O",
                      style: TextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold)))),
    );
  }

  void OnPress() {
    setState(() {
      _arrayIndex++;
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
