import 'package:flutter/material.dart';

// Importação utilizada para pegar a função Future
import 'dart:async';

import 'package:flutter_course/widgets/ui_elements/title_default.dart';

class ProductPage extends StatelessWidget {

  final String title;
  final String description;
  final String imageUrl;
  final double price;

  ProductPage(this.title, this.imageUrl, this.description, this.price);

  Widget _buildProductRow(BuildContext context) {
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
          title: Text(title),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(imageUrl),
              Container(
                padding: EdgeInsets.all(10.0),
                child: TitleDefault(title),
              ),
              _buildProductRow(context),
            ],
          ),
        ),
      ),
    );
  }
}