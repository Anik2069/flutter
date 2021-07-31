import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/widgets/nav.dart';
import 'package:shop_app/widgets/order_item.dart' as ord;

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      drawer: Nav(),
      body: ListView.builder(
        itemBuilder: (ctx,i)=>ord.OrderItem( orderData.orders[i]),
        itemCount: orderData.orders.length,
      ),
    );
  }
}
