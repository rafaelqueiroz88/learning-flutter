import 'package:flutter/material.dart';

// Esta classe representa somente uma instância de uma guia dentro da aplicação
// A função que cria esta guia, já possui um método Scaffold, o que significa
// que esta classe não precisa retornar um método Scaffold (o que pode acabar
// prejudicando o desempenho ou até mesmo o visual da aplicação).
class ProductCreatePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text("Novo produto"),
    );
  }
}