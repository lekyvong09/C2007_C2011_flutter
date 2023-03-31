
import 'package:flutter/material.dart';
import 'package:flutter2/model/cart.dart';
import 'package:provider/provider.dart';

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
    return Dismissible(
        key: ValueKey(productId),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) {
          return showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Message'),
                content: const Text('Do you want to remove the item from the cart'),
                actions: [
                  /// return future boolean value
                  TextButton(child: const Text('No'), onPressed: () => Navigator.of(ctx).pop(false),),
                  TextButton(child: const Text('Yes'), onPressed: () => Navigator.of(ctx).pop(true),),
                ],
              )
          );
        },
        background: Container(
          color: Theme.of(context).errorColor,
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          padding: const EdgeInsets.only(right: 20),
          child: const Icon(Icons.delete, color: Colors.white, size: 40,),
        ),
        onDismissed: (direction) {
          context.read<Cart>().removeItem(productId);
        },
        child: Card(
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
        )
    );
  }

}