import 'package:flutter/material.dart';

class ProductControl extends StatelessWidget {

  final Function addProduct;

  ProductControl(this.addProduct);

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return RaisedButton(
        color: Theme.of(context).primaryColor,
        onPressed: () {
          addProduct({'title': 'Chocolate', 'image': 'assets/food.jpg'});
        }, // Chamada anonima (e no caso, função vazia/sem retorno)
        child: Text("Novo produto"),
      );
  }
}