import 'package:flutter/material.dart';
import '../models/transaction.dart';

import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  "No Transactions added yet!",
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/logo_4.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
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
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        )),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '\$${transactions[index].amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Theme.of(context).primaryColor,
                            //Colors.red
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            transactions[index].title,
                            style: Theme.of(context).textTheme.title,
                          ),
                          Text(
                            // tx.date.toString(),
                            DateFormat.yMMMd().format(transactions[index].date),
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          
                        ],
                      )
                    ],
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}

// children: transactions.map((tx) {
// return Card(
// child: Row(
// children: <Widget>[
// Container(
// margin: EdgeInsets.symmetric(
// vertical: 10,
// horizontal: 15,
// ),
// decoration: BoxDecoration(
// border: Border.all(
// color: Colors.black,
// width: 2,
// )),
// padding: EdgeInsets.all(10),
// child: Text(
// '\$${tx.amount}',
// style: TextStyle(
// fontWeight: FontWeight.bold,
// fontSize: 20,
// color: Colors.purple,
// ),
// ),
// ),
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: <Widget>[
// Text(
// tx.title,
// style: TextStyle(
// fontWeight: FontWeight.bold,
// fontSize: 18,
// ),
// ),
// Text(
// // tx.date.toString(),
// DateFormat.yMMMd().format(tx.date),
// style: TextStyle(
// color: Colors.grey,
// ),
// ),
// ],
// )
// ],
// ),
// );
// }).toList(),
