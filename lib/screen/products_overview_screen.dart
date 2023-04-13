import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter2/model/cart.dart';
import 'package:flutter2/provider/product_provider.dart';
import 'package:flutter2/screen/cart_screen.dart';
import 'package:flutter2/widget/badge.dart';
import 'package:flutter2/widget/navbar_drawer.dart';
import 'package:provider/provider.dart';

import '../widget/products_grid.dart';

enum FilterOptions {
  favorites,
  all,
}

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProductsOverviewScreen();
}

class _ProductsOverviewScreen extends State<ProductsOverviewScreen> {
  bool _showFavoritesOnly = false;
  bool _isLoading = false;

  @override
  void initState() {
    setState(() { _isLoading = true; });
    context.read<ProductProvider>().fetchProducts().then((_) => {
      setState(() { _isLoading = false; })
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My shop'),
        actions: <Widget>[
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(value: FilterOptions.favorites,child: Text('Only favorites'),),
              const PopupMenuItem(value: FilterOptions.all, child: Text('Show All')),
            ],
            onSelected: (FilterOptions selectedValue) => {
              setState(() {
                if (selectedValue == FilterOptions.favorites) {
                  _showFavoritesOnly = true;
                } else {
                  _showFavoritesOnly = false;
                }
              })
            },
          ),
          Consumer<Cart>(
            builder: (ctx, cartData, __) => Badge(
              value: cartData.itemCount.toString(),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () => Navigator.of(context).pushNamed(CartScreen.routeName),),),
          )
        ],
      ),
      drawer: const NavbarDrawer(),
      body: _isLoading ? const Center(child: CircularProgressIndicator())
          : ProductGrid(_showFavoritesOnly),
    );
  }
}