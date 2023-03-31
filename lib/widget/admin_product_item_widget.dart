
import 'package:flutter/material.dart';

class AdminProductItemWidget extends StatelessWidget {
  final String tittle;
  final String imageUrl;

  const AdminProductItemWidget({
    super.key,
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
              IconButton(onPressed: () {}, icon: const Icon(Icons.edit), color: Theme.of(context).primaryColor,),
              IconButton(onPressed: () {}, icon: const Icon(Icons.delete), color: Theme.of(context).errorColor),
            ],
          ),
        ),
        title: Text(tittle),
      ),
    );
  }

}