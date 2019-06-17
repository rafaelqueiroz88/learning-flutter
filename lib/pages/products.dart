import 'package:flutter/material.dart';

import './products_manager.dart';
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
                
                // Método substituido para uso das rotas dinamicas
                // Navigator.pushReplacement(context, MaterialPageRoute(
                  // context removido daqui, e colado em main.dart
                  // builder: ),
                // );

                Navigator.pushReplacementNamed(context, '/admin');
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