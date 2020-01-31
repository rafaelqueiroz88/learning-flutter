import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import 'product_card.dart';
import '../../scoped-models/main.dart';
import '../../models/product.dart';

class Products extends StatelessWidget {

  Widget _buildProductsList(List<Product> products) {

    Widget productCard = Center(
      child: Text("Nenhum prato cadastrado. Adicione algum!"),
    );
    
    if(products.length > 0) {
      productCard = ListView.builder(
        itemBuilder: (BuildContext context, int index) => ProductCard(products[index], index),
        itemCount: products.length,
      );
    }

    return productCard;
  }

  @override
  Widget build(BuildContext context) {

    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model) {
      return _buildProductsList(model.displayedProducts);
    },);
  }
}