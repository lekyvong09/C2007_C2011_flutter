
import 'package:flutter/material.dart';

class AdminProductEditScreen extends StatefulWidget {
  static const routeName = '/product-edit';
  const AdminProductEditScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AdminProductEditScreen();
}


class _AdminProductEditScreen extends State<AdminProductEditScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Product'),),
      body: Form(
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_priceFocusNode),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Unit Price'),
              textInputAction: TextInputAction.next,
              focusNode: _priceFocusNode,
              keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_descriptionFocusNode),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Description'),
              textInputAction: TextInputAction.next,
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              focusNode: _descriptionFocusNode,
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_imageUrlFocusNode),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(top: 10, right: 10),
                  decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: _imageUrlController.text.isEmpty
                      ? const Text('Enter a URL')
                      : Image.network(_imageUrlController.text),
                  ),
                ),
                Expanded(child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Image URL'),
                  textInputAction: TextInputAction.done,
                  focusNode: _imageUrlFocusNode,
                  keyboardType: TextInputType.url,
                  onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_imageUrlFocusNode),
                  controller: _imageUrlController,
                  onEditingComplete: () => setState(() {}),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }

}