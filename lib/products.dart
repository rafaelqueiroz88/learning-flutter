import 'package:flutter/material.dart';

class Products extends StatelessWidget {

  final List<Map<String,dynamic>> products;

  Products(this.products);

  Widget _buildProductionItem(BuildContext context, int index) {
    
    return Card(
        child: Column(
          children: <Widget>[
            Image.asset(products[index]['image']),
            Container(
              padding: EdgeInsets.all(10.0), 
              child: Text(products[index]['title']),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center, 
              children: <Widget>[
                FlatButton(
                  child: Text("Detalhes"), 
                  onPressed: () => Navigator.pushNamed<bool>(context, '/product/' + index.toString())
                  .then((bool value) {
                      if(value) {
                        
                      }                        
                    }),
                  ),
                ],
              )
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