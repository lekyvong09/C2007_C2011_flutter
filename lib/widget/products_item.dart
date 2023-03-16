import 'package:flutter/material.dart';
import 'package:flutter2/screen/product_detail_screen.dart';

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
      GestureDetector(
        onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => ProductDetailScreen(name))
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GridTile(
            header: GridTileBar(
              title: Text(name, textAlign: TextAlign.center, maxLines: 2,),
              backgroundColor: Colors.black54,
            ),
            footer: GridTileBar(
              title: Text(
                "\$${unitPrice.toStringAsFixed(2)}",
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.black54,
              leading: IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () { },
                color: Theme.of(context).colorScheme.secondary,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () { },
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            child: Image.network(imageUrl, fit: BoxFit.fill,),
          ),
        ),
      );
  }

}