import 'package:flutter/material.dart';
import 'package:flutter2/model/cart.dart';
import 'package:flutter2/model/order.dart';
import 'package:flutter2/provider/auth_provider.dart';
import 'package:flutter2/provider/product_provider.dart';
import 'package:flutter2/screen/admin_product_edit_screen.dart';
import 'package:flutter2/screen/admin_product_screen.dart';
import 'package:flutter2/screen/auth_screen.dart';
import 'package:flutter2/screen/cart_screen.dart';
import 'package:flutter2/screen/order_screen.dart';
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
        ChangeNotifierProvider(create: (BuildContext context) => Orders(),),
        ChangeNotifierProvider(create: (BuildContext context) => AuthProvider(),),
      ],
      child: Consumer<AuthProvider>(builder: (ctx, auth, _) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Roboto',
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue,
            accentColor: Colors.deepOrangeAccent,
          ),
        ),
        home: auth.isAuth ? const ProductsOverviewScreen() : const AuthScreen(), // ProductsOverviewScreen(),
        routes: {
          ProductsOverviewScreen.routeName: (ctx) => const ProductsOverviewScreen(),
          ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
          CartScreen.routeName: (ctx) => const CartScreen(),
          OrderScreen.routeName: (ctx) => const OrderScreen(),
          AdminProductScreen.routeName: (ctx) => const AdminProductScreen(),
          AdminProductEditScreen.routeName: (ctx) => const AdminProductEditScreen(),
        },
      ),
    ));
  }
}
