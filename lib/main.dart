import 'package:flutter/material.dart';
import 'package:flutter2/model/cart.dart';
import 'package:flutter2/provider/product_provider.dart';
import 'package:flutter2/screen/cart_screen.dart';
import 'package:flutter2/screen/product_detail_screen.dart';
import 'package:flutter2/screen/products_overview_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => ProductProvider(),),
        ChangeNotifierProvider(create: (BuildContext context) => Cart(),),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Roboto',
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue,
            accentColor: Colors.deepOrangeAccent,
          ),
        ),
        home: const ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
          CartScreen.routeName: (ctx) => const CartScreen(),
        },
      ),
    );
  }
}
