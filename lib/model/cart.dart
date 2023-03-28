import 'dart:developer';

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
    int total = 0;
    _items.forEach((key, value) => total += value.quantity);
    return total;
  }

  int get numberOfItems {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, value) => total += value.unitPrice * value.quantity);
    return total;
  }

  void removeItem(int keyCartItem) {
    _items.remove(keyCartItem);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  void removeSingleItem(int productId) {
    log(productId.toString());
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      log(_items[productId]!.quantity.toString());
      _items.update(productId, (existingCartItem) => CartItem(
        productId: existingCartItem.productId,
        name: existingCartItem.name,
        unitPrice: existingCartItem.unitPrice,
        quantity: existingCartItem.quantity - 1
      ));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }
}