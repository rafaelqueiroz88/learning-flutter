import 'package:flutter/material.dart';

import './pages/product.dart';

class Products extends StatelessWidget {

  /**
   * Class properties
   */
  final List<Map<String, String>> products;
  final Function deleteProduct;

  // Atribuindo valor padrão no construtor, no caso um valor vazio
  // alternativas: [this.products = const []], {this.deleteProduct}
  Products(this.products, {this.deleteProduct});

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
                  onPressed: () => Navigator.push<bool>(context, MaterialPageRoute(

                    // Passando rota dinâmica com parâmetro dinamico
                    // builder: (BuildContext context) 
                        // => ProductPage(products[index]['title'], products[index]['image']),
                      // ),
                    
                    ).then((bool value) {
                      if(value) {
                        deleteProduct(index);
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