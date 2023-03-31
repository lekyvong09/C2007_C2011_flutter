import 'package:flutter/material.dart';
import 'package:flutter2/screen/admin_product_screen.dart';
import 'package:flutter2/screen/order_screen.dart';

class NavbarDrawer extends StatelessWidget {
  const NavbarDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(title: const Text('Menu'),),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Shop'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Orders'),
            onTap: () => Navigator.of(context).pushReplacementNamed(OrderScreen.routeName),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Manage Product'),
            onTap: () => Navigator.of(context).pushReplacementNamed(AdminProductScreen.routeName),
          ),
        ],
      ),
    );
  }

}