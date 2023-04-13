
import 'package:flutter/material.dart';
import 'package:flutter2/provider/product_provider.dart';
import 'package:flutter2/screen/admin_product_edit_screen.dart';
import 'package:provider/provider.dart';

import '../widget/admin_product_item_widget.dart';
import '../widget/navbar_drawer.dart';

class AdminProductScreen extends StatelessWidget {
  static const routeName = '/admin-product';

  const AdminProductScreen({super.key});

  Future<void> _refreshProduct(BuildContext context) async {
    await context.read<ProductProvider>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Products'),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).pushNamed(AdminProductEditScreen.routeName),
              icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const NavbarDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProduct(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
              itemCount: productsData.items.length,
              itemBuilder: (ctx, idx) => AdminProductItemWidget(
                id: productsData.items[idx].id,
                tittle: productsData.items[idx].name,
                imageUrl: productsData.items[idx].imageUrl,
              )
          ),
        ),
      ),
    );
  }

}