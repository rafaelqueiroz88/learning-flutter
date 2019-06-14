import 'package:flutter/material.dart';

import 'dart:async'; // Importação utilizada para pegar a função Future

class ProductPage extends StatelessWidget {

  final String title;
  final String imageUrl;

  ProductPage(this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        print('Back button pressed');
        Navigator.pop(context, false);

        // Função FUTURE importada de: dart:async
        // valor bool passado para garantir o funcionamento
        return Future.value(false); 
      }, 
      child: Scaffold(
        backgroundColor: Colors.redAccent,
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Column(

            // Está aqui para exemplificar o alinhamento vertical
            // mainAxisAlignment: MainAxisAlignment.center,

            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(imageUrl),
              Container(
                padding: EdgeInsets.all(10.0), 
                child: Text("Detalhes de " + title),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  child: Text("Apagar " + title), 
                  onPressed: () => Navigator.pop(context, true),
                ),
              ),
            ],
          ),
        ),
      ),);
  }
}