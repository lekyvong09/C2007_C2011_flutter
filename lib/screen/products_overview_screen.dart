import 'package:flutter/material.dart';

import '../widget/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  const ProductsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My shop'),),
      body: const ProductGrid(),
    );
  }
}