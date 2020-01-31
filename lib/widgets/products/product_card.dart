import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import 'price_tag.dart';
import '../ui_elements/title_default.dart';
import '../ui_elements/address_default.dart';
import '../../models/product.dart';
import '../../scoped-models/main.dart';

class ProductCard extends StatelessWidget {

  final Product product;
  final int productIndex;

  ProductCard(this.product, this.productIndex);

  Widget _buildButtonBar(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[

        IconButton(
          // child: Text("Detalhes"), // IconButton não possui um CHILD
          icon: Icon(Icons.info_outline),
          iconSize: 35.0,
          onPressed: () => Navigator.pushNamed<bool>(context, '/product/' + productIndex.toString())
              .then((bool value) {
            if(value) { }
          }),
        ),
        ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model) {
          return IconButton(
            icon: Icon(
              model.allProducts[productIndex].isFavorite ?
              Icons.favorite : Icons.favorite_border
            ),
            color: Colors.red,
            iconSize: 35.0,
            onPressed: () {
              model.selectProduct(productIndex);
              model.toggleProductFavorite();
            },
          );
        },)

      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Card(
      child: Column(
        children: <Widget>[
          Image.network(product.image),
          // Utilize .asset quando a fonte da imagem for uma fonte local
          // Image.asset(product.image),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[

                TitleDefault(product.title),
                SizedBox(width: 5.0,),
                PriceTag(product.price.toString()),

              ],
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: AddressDefault('162. Potim, Rua Luis Tomas de Lima'),
          ),
          Text("Postado por: ${product.userEmail}"),
          // Text(product.userEmail),
          _buildButtonBar(context),
        ],
      ),
    );
  }
}