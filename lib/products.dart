import 'package:flutter/material.dart';

class Products extends StatelessWidget {

  /**
   * Class properties
   */
  final List<String> products;

  // Atribuindo valor padrão no construtor, no caso um valor vazio
  Products([this.products = const []]);

  Widget _buildProductionItem(BuildContext context, int index) {
    return Card(
        child: Column(
          children: <Widget>[
            Image.asset("assets/food.jpg"),
            Text(products[index]),
          ],
        ),
      );
  }

  Widget _buildProductsList() {

    // Condicional convencional (aceita multiplas condições)
    Widget productCard = Center(child: Text("There are no foods in here. Please add some!"),);
    if(products.length > 0) {

      productCard = ListView.builder(
        itemBuilder: _buildProductionItem,
        itemCount: products.length,
      );
    }

    return productCard;

    // Alternativa para condicionais simples
    // return products.length > 0 ? ListView.builder(
    //   itemBuilder: _buildProductionItem,
    //   itemCount: products.length,
    // ) : Center(child: Text("There are no foods in here. Please add some!"),);
  }

  @override
  Widget build(BuildContext context) {
    
    return _buildProductsList();   
  }
}