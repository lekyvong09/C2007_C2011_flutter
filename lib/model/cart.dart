import 'package:flutter/material.dart';

class CartItem {
  final int productId;
  final String name;
  final int quantity;
  final double unitPrice;

  CartItem({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.unitPrice});
}


class Cart with ChangeNotifier {
  final Map<int, CartItem> _items = {};

  Map<int, CartItem> get items {
    return {..._items};
  }

  void addItem(int productId, double unitPrice, String name) {
    if (_items.containsKey(productId)) {
      _items.update((productId), (existingCartItem) => CartItem(
        productId: existingCartItem.productId,
        name: existingCartItem.name,
        quantity: existingCartItem.quantity + 1,
        unitPrice: existingCartItem.unitPrice,
      ));
    } else {
      _items.putIfAbsent(productId, () => CartItem(
        productId: productId,
        name: name,
        quantity: 1,
        unitPrice: unitPrice,
      ));
    }
    notifyListeners();
  }

  int get itemCount {
    return _items.length;
  }
}