import 'package:flutter/material.dart';

import '../widgets/products/products.dart';

class ProductsPage extends StatelessWidget {

  final List<Map<String,dynamic>> products;

  ProductsPage(this.products);

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Toque em uma Ação'),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Gerenciar Produtos'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/admin');
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.redAccent,
      drawer: _buildSideDrawer(context),
      appBar: AppBar(
        title: Text("Foods"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
          ),
        ],
      ),
      body: Products(products),
    );
  }
}