import 'package:flutter/material.dart';

import '../model/order.dart';

class OrderItemWidget extends StatelessWidget {
  final Order order;

  const OrderItemWidget(this.order, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text('\$${order.totalPrice}'),
        trailing: IconButton(
          icon: const Icon(Icons.expand_more),
          onPressed: () {},
        ),
      ),
    );
  }

}