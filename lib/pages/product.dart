import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

// Importação utilizada para pegar a função Future
import 'dart:async';

import 'package:flutter_course/widgets/ui_elements/title_default.dart';
import '../scoped-models/main.dart';
import '../models/product.dart';

class ProductPage extends StatelessWidget {

  final Product product;

  ProductPage(this.product);

  Widget _buildProductRow(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10.0),
          child: RaisedButton(
            color: Theme.of(context).accentColor,
            child: Text("Apagar " + title),
            onPressed: () => _showWarningDialog(context),
          ),
        ),
      ],
    );
  }

  _showWarningDialog(BuildContext context) {

    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Tem certeza?"),
        content: Text("Esta ação NÃO PODE ser desfeita"),
        actions: <Widget>[
          FlatButton(
            child: Text("Cancelar"), 
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text("Apagar"),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, true);
            },  
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () {
        print('Back button pressed');
        Navigator.pop(context, false);

        return Future.value(false); 
      }, 
      child: Scaffold(
        backgroundColor: Colors.orangeAccent,
        appBar: AppBar(
          title: Text(product.title),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FadeInImage(
                image: NetworkImage(product.image),
                placeholder: AssetImage('assets/food.jpg'),
                height: 300.0,
                fit: BoxFit.cover,
              ),
              // Utilize .asset quando a fonte da imagem for uma fonte local
              // Image.asset(product.image),
              Container(
                padding: EdgeInsets.all(10.0),
                child: TitleDefault(product.title),
              ),
              _buildProductRow(context, product.title),
            ],),
        ),
      ),
    );
  }
}