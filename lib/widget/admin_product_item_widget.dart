
import 'package:flutter/material.dart';
import 'package:flutter2/provider/product_provider.dart';
import 'package:flutter2/screen/admin_product_edit_screen.dart';
import 'package:provider/provider.dart';

class AdminProductItemWidget extends StatelessWidget {
  final String tittle;
  final String imageUrl;
  final int id;

  const AdminProductItemWidget({
    super.key,
    required this.id,
    required this.tittle,
    required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl),),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pushNamed(AdminProductEditScreen.routeName, arguments: id), 
                icon: const Icon(Icons.edit), 
                color: Theme.of(context).primaryColor,),
              IconButton(
                  onPressed: () => context.read<ProductProvider>().deleteProduct(id), 
                  icon: const Icon(Icons.delete), 
                  color: Theme.of(context).errorColor),
            ],
          ),
        ),
        title: Text(tittle),
      ),
    );
  }

}