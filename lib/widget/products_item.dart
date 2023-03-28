import 'package:flutter/material.dart';
import 'package:flutter2/screen/product_detail_screen.dart';
import 'package:provider/provider.dart';

import '../model/product.dart';
import '../model/cart.dart';

class ProductsItem extends StatelessWidget {

  const ProductsItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = context.read<Product>();
    final cart = context.read<Cart>();

    return
      GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(
            ProductDetailScreen.routeName, arguments: product.id
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GridTile(
            header: GridTileBar(
              title: Text(product.name, textAlign: TextAlign.center, maxLines: 2,),
              backgroundColor: Colors.black54,
            ),
            footer: GridTileBar(
              title: Text(
                "\$${product.unitPrice.toStringAsFixed(2)}",
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.black54,
              leading: Consumer<Product>(builder: (ctx, productProvider, child) => IconButton(
                icon: Icon(productProvider.isFavorite ? Icons.favorite : Icons.favorite_border),
                onPressed: () => productProvider.toggleFavoriteStatus(),
                color: Theme.of(context).colorScheme.secondary,
              ),),
              trailing: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () => {
                  cart.addItem(product.id, product.unitPrice, product.name),
                  ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Added item to cart'),
                      duration: const Duration(seconds: 2),
                      action: SnackBarAction(label: 'UNDO', onPressed: () => cart.removeSingleItem(product.id),),
                    )
                  )
                },
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            child: Image.network(product.imageUrl, fit: BoxFit.fill,),
          ),
        ),
      );
  }

}