import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/products_item.dart';
import '../provider/product_provider.dart';

import '../model/product.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final productData = context.watch<ProductProvider>(); ///Provider.of<ProductProvider>(context)
    final products = productData.items;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2/3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemBuilder: (ctx, idx) => ChangeNotifierProvider(
        create: (BuildContext context) => products[idx],
        child: ProductsItem(),
      ) ,
      itemCount: products.length,
      padding: const EdgeInsets.all(10),
    );
  }

}