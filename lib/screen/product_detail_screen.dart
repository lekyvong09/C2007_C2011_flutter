import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/product_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as int;
    final productItem = context.watch<ProductProvider>().findById(productId);
    return Scaffold(
      appBar: AppBar(title: Text(productItem.name),),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          children: [
            SizedBox(
              height: 300,
              child: Image.network(productItem.imageUrl, fit: BoxFit.cover),
            ),
            const SizedBox(height: 10,),
            Text('\$${productItem.unitPrice}', style: const TextStyle(color: Colors.grey, fontSize: 20),),
            const SizedBox(height: 10,),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(productItem.description, textAlign: TextAlign.center, softWrap: true,),
            ),
          ],
        ),
      ),
    );
  }

}