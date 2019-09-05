import 'package:flutter/material.dart';

import './product_create.dart';
import './products_list.dart';

class ProductsManagePage extends StatelessWidget {

  final Function addProduct;
  final Function deleteProduct;

  ProductsManagePage(this.addProduct, this.deleteProduct);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: Scaffold(
        // backgroundColor: Colors.redAccent,
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false,
                title: Text('Toque em uma Ação'),
              ),
              ListTile(
                leading: Icon(Icons.shop),
                title: Text('Ver Produtos'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/products');
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("Gerenciar Produtos"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                  icon: Icon(Icons.create),
                  text: 'Novo Produto',
                ),
              Tab(
                icon: Icon(Icons.list),
                text: 'Todos Produtos',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ProductCreatePage(addProduct),
            ProductsListePage(),
          ],
        ),
      ),);
  }
}