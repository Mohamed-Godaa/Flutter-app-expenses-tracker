// ignore_for_file: prefer_const_constructors, deprecated_member_use, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import 'models/transaction.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: MyHomePage(),
      theme: ThemeData(
        errorColor: Colors.red,
        textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
            ),
            button: TextStyle(color: Colors.white)),
        primarySwatch: Colors.purple,
        fontFamily: 'QuickSand',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                ),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [];

  List<Transaction> get _recentTransactions {
    return transactions.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void addNewTransaction(
    String title,
    double amount,
    DateTime date,
  ) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
    );

    setState(() => transactions.add(newTx));

    Navigator.of(context).pop();
  }

  void removeTransaction(String id) {
    setState(
      () => transactions.removeWhere((element) => element.id == id),
    );
  }

  void StartAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return NewTransaction(addNewTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    final AppBar myAppBar = AppBar(title: Text('Personal Expenses'), actions: [
      IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          StartAddNewTransaction(context);
        },
      ),
    ]);
    return Scaffold(
      appBar: myAppBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: (mediaquery.size.height -
                      mediaquery.padding.top -
                      myAppBar.preferredSize.height) *
                  0.3,
              child: Chart(_recentTransactions),
            ),
            Container(
              height: (mediaquery.size.height -
                      mediaquery.padding.top -
                      myAppBar.preferredSize.height) *
                  0.7,
              child: TransactionList(transactions, removeTransaction),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          StartAddNewTransaction(context);
        },
      ),
    );
  }
}
