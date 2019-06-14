import 'package:flutter/material.dart';

import './productsmanager.dart';
import '../product_manager.dart';

class ProductsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.redAccent,
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text('Toque em uma Ação'),
            ),
            ListTile(
              title: Text('Gerenciar Produtos'),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (BuildContext context) => ProductsManagePage(),),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Foods"),
      ),
      body: ProductManager(),
    );
  }
}