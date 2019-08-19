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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    products[index]['title'], 
                    style: TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold, fontFamily: "alexbrush"
                    )
                  ),
                  SizedBox(width: 5.0,),
                  Container(
                    decoration: BoxDecoration(color: Theme.of(context).accentColor, borderRadius: BorderRadius.circular(4.0)),
                    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 5.0),
                    child: Text(
                      'R\$ ' + products[index]['price'].toString(),
                      style: TextStyle(
                        color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold, fontFamily: "alexbrush"
                      )
                    ),
                  ),
                ],
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
                child: Text('162. Potim, Rua Luis Tomas de Lima'),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center, 
              children: <Widget>[
                FlatButton(
                  child: Text("Detalhes"), 
                  onPressed: () => Navigator.pushNamed<bool>(context, '/product/' + index.toString())
                  .then((bool value) {
                      if(value) { }
                    }),
                  ),
                ],
              )
          ],
        ),
      );
  }

  Widget _buildProductsList() {

    Widget productCard = Center(child: Text("Nenhum prato cadastrado. Adicione algum!"),);
    if(products.length > 0) {
      productCard = ListView.builder(
        itemBuilder: _buildProductionItem,
        itemCount: products.length,
      );
    }

    return productCard;
  }

  @override
  Widget build(BuildContext context) {    
    return _buildProductsList();   
  }
}