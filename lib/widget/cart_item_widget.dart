
import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final int productId;
  final double unitPrice;
  final int quantity;
  final String name;

  const CartItemWidget({super.key,
    required this.productId,
    required this.unitPrice,
    required this.quantity,
    required this.name});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: FittedBox(child: Text('\$${unitPrice.toStringAsFixed(0)}'),),
            ),
          ),
          trailing: Text(quantity.toStringAsFixed(0)),
          title: Text(name),
          subtitle: Text('Total: \$${(unitPrice * quantity).toStringAsFixed(0)}'),
        ),
      ),
    );
  }

}