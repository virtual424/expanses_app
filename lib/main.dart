import 'package:expanses_app/widgets/chart.dart';
import 'package:expanses_app/widgets/new_Transactions.dart';
import 'package:expanses_app/widgets/transactionsList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/Transactions.dart';

void main() {
  //below code is to restrict the orientaion of the app .
  // SystemChrome.setPreferredOrientations(
  //     [
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown
  //     ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expanse',
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'QuickSand',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6 /*title*/ : TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              button: TextStyle(color: Colors.white)),
          errorColor: Colors.red,
          /* here below code means that apply a theme to appbar with the default textTheme(texttheme changes the theme of all the text in the appbar) along with our coustomizations . also innside the copyWith we are applyin the fontfamily to only the title text  of the appbar*/
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6 /*title*/ : TextStyle(
                      fontFamily: 'QuickSand',
                      fontSize: 20,
                      fontWeight: FontWeight.bold)))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  final List<Transactions> _transactionsList = [
    // Transactions(
    //     id: "t1", title: "New Shoes", amount: 69.99, date: DateTime.now()),
    // Transactions(
    //     id: "t2", title: "Groceries", amount: 16.53, date: DateTime.now())
  ];

  var _showChart = false;

  List<Transactions> get _recentTransactions {
    return _transactionsList.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList(); //since where returns an iterable we want to return a list .
  }

  void _addTransactions(String txTitle, double txAmount, DateTime chosenDate) {
    final newTransaction = Transactions(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: chosenDate);

    setState(() {
      _transactionsList.add(newTransaction);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builderContext) {
          return NewTransactions(_addTransactions);
        });
  }

  void _deleteTranscations(String id) {
    setState(() {
      _transactionsList.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape =
        mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text('Personal Expanse'),
      actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context))
      ],
    );

    final transactionListWidget = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionsList(_transactionsList, _deleteTranscations));

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (isLandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Show Chart"),
                    Switch(
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      },
                    ),
                  ],
                ),
              if (!isLandscape)
                Container(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.3,
                    child: Chart(_recentTransactions)),
              if (!isLandscape) transactionListWidget,
              if (isLandscape)
                _showChart
                    ? Container(
                        height: (mediaQuery.size.height -
                                appBar.preferredSize.height -
                                mediaQuery.padding.top) *
                            0.7,
                        child: Chart(_recentTransactions))
                    : transactionListWidget
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
