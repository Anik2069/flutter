import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/widgets/nav.dart';
import 'package:shop_app/widgets/order_item.dart' as ord;

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;

  void initState() {
    Future.delayed(Duration.zero).then((_) async => {
          setState(() {
            _isLoading = true;
          }),
          Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
          setState(() {
            _isLoading = false;
          }),
        });
    super.initState();
  }

  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      drawer: Nav(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (ctx, i) => ord.OrderItem(orderData.orders[i]),
              itemCount: orderData.orders.length,
            ),
    );
  }
}
