import 'dart:io';

import 'package:expenses_app/widgets/chart.dart';
import 'package:expenses_app/widgets/new_transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/transaction.dart';
import 'widgets/transaction_list.dart';
import 'widgets/chart.dart';

void main() {
  // Code to block the landscape mode (Only allow portrait mode in the app):
  /* WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]); */
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          // NEW FLUTTER identifiers
          // display4 => headline1;
          // display3 => headline2;
          // display2 => headline3;
          // display1 => headline4;
          // headline => headline5;
          // title    => headline6; // used in previous lecture
          // subhead  => subtitle1;
          // subtitle => subtitle2;
          // body2    => bodyText1; // will be used in future lectures
          // body     => bodyText2; // will be used in future lectures

          primarySwatch: Colors.green,
          accentColor: Colors.blueAccent,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  button: TextStyle(color: Colors.white),
                  headline6: TextStyle(fontFamily: 'OpenSans', fontSize: 20)))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [];

  final List<Transaction> _userTransactions = [
    // Transaction(amount: 39.99, date: DateTime.now(), id: 't1', title: 'Vans'),
    // Transaction(amount: 499.99, date: DateTime.now(), id: 't2', title: 'PS5'),
    // Transaction(
    //     amount: 9.99, date: DateTime.now(), id: 't3', title: 'Hamburguers')
  ];

  bool _showChart = false;

  List<Transaction> get _recentTrans {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(String title, double amount, DateTime choosenDate) {
    final newTx = Transaction(
        amount: amount,
        date: choosenDate,
        id: DateTime.now().toString(),
        title: title);
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTrans(String id) {
    setState(() {
      _userTransactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  // String? titleInput;
  void _startAddNewTrans(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return NewTransaction(_addTransaction);
        });
  }

  PreferredSizeWidget _createAppbar() {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Personal Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTrans(context),
                )
              ],
            ),
          ) as PreferredSizeWidget
        : AppBar(
            title: Text('Personal expenses'),
            actions: [
              IconButton(
                  onPressed: () => _startAddNewTrans(context),
                  icon: Icon(Icons.add))
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = _createAppbar();
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final txListWidget = Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: TransactionList(_userTransactions, _deleteTrans));

    final pageBody = SafeArea(
        child: ListView(
      children: <Widget>[
        if (isLandscape)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Show Chart',
                style: Theme.of(context).textTheme.headline6,
              ),
              Switch.adaptive(
                  activeColor: Theme.of(context).accentColor,
                  value: _showChart,
                  onChanged: (val) {
                    setState(() {
                      _showChart = val;
                    });
                  })
            ],
          ),
        if (!isLandscape)
          Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.3,
              child: Chart(_recentTrans)),
        if (!isLandscape) txListWidget,
        if (isLandscape)
          _showChart
              ? Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.7,
                  child: Chart(_recentTrans))
              : txListWidget
      ],
    ));
    // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar as ObstructingPreferredSizeWidget,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTrans(context),
                  ));
  }
}
