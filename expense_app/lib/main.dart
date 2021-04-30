import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './transaction.dart';

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
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  //Making list of transaction
  final List<Transaction> transactions = [
    Transaction(
      id: "T1",
      title: "Books",
      amount: 120.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: "T2",
      title: "Pen",
      amount: 10.00,
      date: DateTime.now(),
    ),
  ];

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
        title: Text("Expence Apps"),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.blue,
              child: Text("Charts Here"),
              elevation: 5,
            ),
          ),
          //input Field
          Card(
            elevation: 5, //inner padding and margin
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Amount'),
                  ),
                  FlatButton(onPressed: () {}, child: Text('Add Transaction'),textColor: Colors.purple,)
                ],
              ),
            ),
          ),
          //List of Transaction
          Column(
            children: transactions.map((tx) {
              return Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.black,
                        width: 2,
                      )),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        '\$${tx.amount}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          tx.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          // tx.date.toString(),
                          DateFormat.yMMMd().format(tx.date),
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
