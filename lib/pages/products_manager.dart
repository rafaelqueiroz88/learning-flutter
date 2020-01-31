import 'package:flutter/material.dart';

import './product_edit.dart';
import './products_list.dart';
import '../scoped-models/main.dart';

class ProductsManagePage extends StatelessWidget {

  final MainModel model;

  ProductsManagePage(this.model);

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
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
    );
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.orangeAccent,
        // backgroundColor: Colors.redAccent,
        drawer: _buildSideDrawer(context),
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
          children: <Widget>[ProductEditPage(), ProductsListPage(model),],
        ),
      ),
    );
  }
}