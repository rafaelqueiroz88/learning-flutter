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
    return Container(
      margin: EdgeInsets.all(40.0),
      child: ListView(
      children: <Widget>[
        TextField(
          autofocus: true,
          decoration: InputDecoration(
            labelText: 'Product Title',
          ),
        ),
        Text(title.toString()),

        TextField(
          maxLines: 4,
          decoration: InputDecoration(
            labelText: 'Product Description',
          ),
        ),
        Text(description),

        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Product Price',
          ),
          onChanged: (String value) {
            setState() {
              price = double.parse(value);
            }
          },
        ),
        RaisedButton(child: Text("Salvar"), onPressed: () {
          
        },)
      ],
    ),);
  }
}