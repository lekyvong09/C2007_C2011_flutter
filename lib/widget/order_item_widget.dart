import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/order.dart';

class OrderItemWidget extends StatefulWidget {
  final Order order;

  const OrderItemWidget(this.order, {super.key});

  @override
  State<StatefulWidget> createState() => _OrderItemWidget();
}

class _OrderItemWidget extends State<OrderItemWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(children: [
        ListTile(
          title: Text('\$${widget.order.totalPrice}'),
          subtitle: Text(DateFormat('dd/MM/yyyy HH:mm').format(widget.order.dateTime)),
          trailing: IconButton(
            icon: const Icon(Icons.expand_more),
            onPressed: () => setState(() {
              _expanded = !_expanded;
            }),
          ),
        ),
        if (_expanded)
          Container(
            height: min(widget.order.cartItems.length * 20.0 + 10, 100),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            child: ListView(
                children: widget.order.cartItems.map((item) =>
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item.name, style: const TextStyle(fontSize: 14),),
                        Text('${item.quantity} x \$${item.unitPrice}', style: const TextStyle(fontSize: 14, color: Colors.grey),)
                      ],
                    ),
                ).toList()
            ),
          ),
      ],),
    );
  }

}