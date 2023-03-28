import 'package:flutter/material.dart';
import 'package:flutter2/model/cart.dart';
import 'package:provider/provider.dart';

import '../model/order.dart';
import '../widget/cart_item_widget.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Cart>();

    return Scaffold(
      appBar: AppBar(title: const Text('Shopping cart'),),
      body: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total', style: TextStyle(fontSize: 20,),),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(0)}',
                      style: TextStyle(color: Theme.of(context).primaryTextTheme.headline6!.color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 10,),
                  TextButton(
                    onPressed: () {
                      context.read<Orders>().addOrder(cart.items.values.toList(), cart.totalAmount);
                      cart.clear();
                    },
                    child: const Text('ORDER NOW'),
                  )
                ],
              ),
            ),
          ),

          Expanded(
              child: ListView.builder(
                itemCount: cart.numberOfItems,
                itemBuilder: (ctx, idx) => CartItemWidget(
                  productId: cart.items.values.toList()[idx].productId,
                  unitPrice: cart.items.values.toList()[idx].unitPrice,
                  quantity: cart.items.values.toList()[idx].quantity,
                  name: cart.items.values.toList()[idx].name,
                )
              )
          ),
        ],
      ),
    );
  }

}