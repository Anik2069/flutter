import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:shop_app/providers/cart.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(this.id, this.amount, this.products, this.dateTime);
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String authToken;

  Orders(this.authToken,this._orders);
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartPrduct, double total) async {
    final url =
        "https://shop-app-1c56b-default-rtdb.firebaseio.com/orders.json?auth=$authToken";
    final timeStamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'dateTime': timeStamp.toIso8601String(),
        'products': cartPrduct
            .map((cp) => {
                  'id': cp.id,
                  'title': cp.title,
                  'quantity': cp.quantity,
                  'price': cp.price
                })
            .toList(),
      }),
    );
    _orders.insert(
      0,
      OrderItem(
        json.decode(response.body)['name'],
        total,
        cartPrduct,
        DateTime.now(),
      ),
    );
    notifyListeners();
  }

  Future<void> fetchAndSetOrders() async {
    final url =
        "https://shop-app-1c56b-default-rtdb.firebaseio.com/orders.json?auth=$authToken";
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extreactedData = json.decode(response.body) as Map<String, dynamic>;
    if (extreactedData == null) {
      return;
    }
    extreactedData.forEach((key, value) {
      loadedOrders.add(
        OrderItem(
          key,
          value['amount'],
          (value['products'] as List<dynamic>)
              .map(
                (item) => CartItem(
                    item['id'],item['title'] , item['quantity'],item['price'] ),
              )
              .toList(),
          DateTime.parse(value['datetime']),
        ),
      );
    });
    _orders = loadedOrders;
    notifyListeners();
    // loadedOrders.add(OrderItem(
    //     key, value['amount'],(value['products'] as List<dynamic>).map((item) =>
    //     CartItem(item['id'], item['id'], item['price'], item['quantity'],
    //       item['title'],),).toList(), DateTime.parse(value['datetime']));
    // });
  }
}
