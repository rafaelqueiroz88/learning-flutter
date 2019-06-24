import 'package:flutter/material.dart';
import './products.dart';
import './product_control.dart';

class ProductManager extends StatelessWidget {

  List<Map<String,String>> _products;
  Function _addProduct;
  Function _deleteProduct;

  ProductManager(this._products, this._addProduct, this._deleteProduct);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10.0),
          child: ProductControl(_addProduct),
        ),
        Expanded(child: Products(_products, deleteProduct: _deleteProduct)),
      ],
    );
  }
}