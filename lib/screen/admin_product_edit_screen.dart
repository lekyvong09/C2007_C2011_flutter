
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product.dart';
import '../provider/product_provider.dart';

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
  final _form = GlobalKey<FormState>();
  Timer _timer = Timer(const Duration(milliseconds: 1), () { });

  bool _isLoading = false;

  _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (_imageUrlController.text.isEmpty
          || (!_imageUrlController.text.startsWith('http')
              && !_imageUrlController.text.startsWith('https'))
          || (!_imageUrlController.text.endsWith('.png')
              && !_imageUrlController.text.endsWith('.jpg')
              && !_imageUrlController.text.endsWith('.jpeg'))
      ) {
        return;
      }
      setState(() { });
    }
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _timer.cancel();
    super.dispose();
  }

  Future<void> _saveForm() async {
    bool isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    _form.currentState!.save();
    // print(_editedProduct);
    // print(_editedProduct.id > 0);
    // print(_editedProduct.id.runtimeType);
    if (_editedProduct.id > 0) {
      try {
        await context.read<ProductProvider>().updateProduct(_editedProduct.id, _editedProduct);
      } catch (error) {
        log(error.toString());
        await showDialog<Null>(context: context, builder: (ctx) => AlertDialog(
          title: const Text('Error'),
          content: Text(error.toString()),
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: () => {Navigator.of(ctx).pop()},
            ),
          ],
        ),);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }

      setState(() {_isLoading = false;});
    } else {
      try {
        await context.read<ProductProvider>().addProduct(_editedProduct);
      } catch (error) {
        await showDialog<Null>(
            context: context,
            builder: (ctx) => AlertDialog(
                title: const Text('Error'),
                content: Text(error.toString()),
                actions: [TextButton(
                  child: const Text('Ok'),
                  onPressed: () => Navigator.of(ctx).pop(),
                )]
            ));
      } finally {
        setState(() {_isLoading = false;});
        Navigator.of(context).pop();
      }
    }
  }

  Product _editedProduct = Product(
    id: 0,
    name: '',
    description: '',
    unitPrice: 0,
    imageUrl: '',
  );

  var _initValue = {
    'name': '',
    'description': '',
    'unitPrice': '',
    'imageUrl': '',
  };

  @override
  Widget build(BuildContext context) {

    if (ModalRoute.of(context)?.settings.arguments != null) {
      final productId = ModalRoute.of(context)?.settings.arguments as int;
      log(productId.toString());

      if (productId != 0) {
        _editedProduct = context.read<ProductProvider>().findById(productId);
        _initValue = {
          'name': _editedProduct.name,
          'description': _editedProduct.description,
          'unitPrice': _editedProduct.unitPrice.toString(),
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [IconButton(onPressed: _saveForm, icon: const Icon(Icons.save))],
      ),
      body: _isLoading ? const Center(child: CircularProgressIndicator()) : Form(
        key: _form,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              textInputAction: TextInputAction.next,
              initialValue: _initValue['name'],
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_priceFocusNode),
              onSaved: (value) => _editedProduct = Product(
                id: _editedProduct.id,
                name: value!,
                description: _editedProduct.description,
                unitPrice: _editedProduct.unitPrice,
                imageUrl: _editedProduct.imageUrl,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please provide product name';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Unit Price'),
              textInputAction: TextInputAction.next,
              initialValue: _initValue['unitPrice'],
              focusNode: _priceFocusNode,
              keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_descriptionFocusNode),
              onSaved: (value) => _editedProduct = Product(
                id: _editedProduct.id,
                name: _editedProduct.name,
                description: _editedProduct.description,
                unitPrice: double.parse(value!),
                imageUrl: _editedProduct.imageUrl,
              ),
              validator: (value) {
                if (value!.isEmpty) { return 'Please provide unit price as a number';}
                if (double.tryParse(value) == null) { return 'Please enter a number for unit price';}
                if (double.parse(value) <= 0) { return 'Please enter a number greater than 0'; }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Description'),
              textInputAction: TextInputAction.next,
              initialValue: _initValue['description'],
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              focusNode: _descriptionFocusNode,
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_imageUrlFocusNode),
              onSaved: (value) => _editedProduct = Product(
                id: _editedProduct.id,
                name: _editedProduct.name,
                description: value!,
                unitPrice: _editedProduct.unitPrice,
                imageUrl: _editedProduct.imageUrl,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please provide product name';
                }
                return null;
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(top: 10, right: 10),
                  decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
                  child: _imageUrlController.text.isEmpty
                      ? const Text('Enter a URL')
                      : FittedBox(fit: BoxFit.cover, child: Image.network(_imageUrlController.text),),
                ),
                Expanded(child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Image URL'),
                  textInputAction: TextInputAction.done,
                  focusNode: _imageUrlFocusNode,
                  keyboardType: TextInputType.url,
                  onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_imageUrlFocusNode),
                  controller: _imageUrlController,
                  onEditingComplete: () => setState(() {}),
                  onSaved: (value) => _editedProduct = Product(
                    id: _editedProduct.id,
                    name: _editedProduct.name,
                    description: _editedProduct.description,
                    unitPrice: _editedProduct.unitPrice,
                    imageUrl: value!,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {return 'Please enter a URL for image';}
                    if (!value.startsWith('http') && !value.startsWith('https')) {return 'Please enter a valid URL';}
                    if (!value.endsWith('.png') && !value.endsWith('.jpg') && !value.endsWith('.jpeg')) {
                      return 'Please enter a valid URL';
                    }
                    return null;
                  },
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }

}