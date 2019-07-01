import 'package:flutter/material.dart';

// Esta classe representa somente uma instância de uma guia dentro da aplicação
// A função que cria esta guia, já possui um método Scaffold, o que significa
// que esta classe não precisa retornar um método Scaffold (o que pode acabar
// prejudicando o desempenho ou até mesmo o visual da aplicação).
class ProductCreatePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductCreatePage();
  }
}

class _ProductCreatePage extends State<ProductCreatePage> {

  String title = "Nome do produto";
  String description = "Descrição";
  double price = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // Comentado para dar inicio aos inputs manuais em tela
    // return Center(
    //   child: RaisedButton(
    //     child: Text("Salvar"),
    //     onPressed: () {
    //       showModalBottomSheet(
    //         context: context,
    //         builder: (BuildContext context) {
    //           return Center(child: Text("Teste"),);
    //         }
    //       );
    //     },
    //   ),
    // );
    return Column(children: <Widget>[
      TextField(
        autofocus: true,
        onChanged: (String value) {
          setState(() {
            title = value;
            if(title == '')
              title = "Nome do produto";
          });
        },
      ),
      Text(title.toString()),

      TextField(
        onChanged: (String value) {
          setState(() {
            description = value;
            if(description == '')
              description = 'Descrição';
          });
        },
      ),
      Text(description),

      TextField(
        keyboardType: TextInputType.number,
        onChanged: (String value) {
          setState(() {
            price = double.parse(value);
          });
        },
      ),
      // Text(price.toString()),
    ],);
  }
}