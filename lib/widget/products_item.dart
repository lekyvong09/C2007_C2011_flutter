import 'package:flutter/material.dart';

class ProductsItem extends StatelessWidget {
  final int id;
  final String name;
  final String imageUrl;
  final double unitPrice;

  const ProductsItem({super.key,
    required this.id, required this.name, required this.imageUrl, required this.unitPrice});

  @override
  Widget build(BuildContext context) {
    return
      GridTile(
        header: GridTileBar(
          title: Text(name, textAlign: TextAlign.center, maxLines: 2,),
          backgroundColor: Colors.black54,
        ),
        footer: GridTileBar(
          title: Text("\$${unitPrice.toStringAsFixed(2)}", textAlign: TextAlign.center,),
          backgroundColor: Colors.black54,
        ),
        child: Image.network(imageUrl, fit: BoxFit.fill,),
      );
  }

}