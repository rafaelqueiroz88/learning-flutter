import 'package:flutter/material.dart';

import 'price_tag.dart';
import '../ui_elements/title_default.dart';
import '../ui_elements/address_default.dart';
import '../../models/product.dart';

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
        IconButton(
          icon: Icon(Icons.favorite_border),
          color: Colors.red,
          iconSize: 35.0,
        ),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(product.image),
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
          _buildButtonBar(context),
        ],
      ),
    );
  }
}