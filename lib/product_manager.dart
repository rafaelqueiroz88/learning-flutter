import 'package:flutter/material.dart';
import './products.dart';

class ProductManager extends StatelessWidget {

  List<Map<String,dynamic>> _products;

  ProductManager(this._products);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Expanded(child: Products(_products)),
      ],
    );
  }
}