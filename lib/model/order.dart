import 'package:flutter/cupertino.dart';

import 'cart.dart';

class Order {
  final String orderTrackingNumber;
  final double totalPrice;
  final List<CartItem> cartItems;
  final DateTime dateTime;

  Order({
    required this.orderTrackingNumber,
    required this.totalPrice,
    required this.cartItems,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartItems, double total) {
    _orders.insert(
        0,
        Order(
          orderTrackingNumber: DateTime.now().microsecondsSinceEpoch.toString(),
          totalPrice: total,
          dateTime: DateTime.now(),
          cartItems: cartItems,
        )
    );
    notifyListeners();
  }
}