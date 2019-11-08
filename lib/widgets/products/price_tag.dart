import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {

  final String price;

  PriceTag(this.price);

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor, 
        borderRadius: BorderRadius.circular(4.0)
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 6.0, 
        vertical: 5.0
      ),
      child: Text('R\$ ${price}',
        style: TextStyle(
          color: Colors.white, 
          fontSize: 20.0, 
          fontWeight: FontWeight.bold, 
          fontFamily: "alexbrush"
        ),
      ),
    );
  }
}