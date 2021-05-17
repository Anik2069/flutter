import 'package:first_app/widget/new_transactions.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widget/transaction_list.dart';
import './widget/new_transactions.dart';
import './widget/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: "OpenSans",
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 20,
                    fontWeight: FontWeight.bold))),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Making list of transaction
  final List<Transaction> transactions = [
    // Transaction(
    //   id: "T1",
    //   title: "Books",
    //   amount: 120.00,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: "T2",
    //   title: "Pen",
    //   amount: 10.00,
    //   date: DateTime.now(),
    // ),
  ];

  //variable for input field
  String titleInput;
  String amountInput;

  //
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: "T1",
    //   title: "Books",
    //   amount: 120.00,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: "T2",
    //   title: "Pen",
    //   amount: 10.00,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txtitle, double txamount, DateTime chooseDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txtitle,
      amount: txamount,
      date: chooseDate,
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  //Model
  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("Expence Apps"),
    //   ),
    //   body: Column(
    //     children: <Widget>[
    //       Card(
    //         color: Colors.blue,
    //         child: Container(
    //           width: 100, //double.infinity
    //           child: Text("Charts"),
    //         ),
    //         elevation: 5,
    //       ),
    //       Container(
    //         width: double.infinity,
    //         child: Card(
    //           color: Colors.blue,
    //           child: Text("List Here"),
    //           elevation: 5,
    //         ),
    //       ),
    //     ],
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Apps", style: TextStyle(fontFamily: 'Open Sans')),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => startAddNewTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Container(
            //   width: double.infinity,
            //
            //   // child: Card(
            //   //   color: Colors.blue,
            //   //   child: Text("Charts Here"),
            //   //   elevation: 5,
            //   // ),
            // ),
            Chart(_recentTransaction),
            //input Field
            //UserTransactions()
            TransactionList(_userTransactions),
          ],
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddNewTransaction(context),
      ),
    );
  }
}
