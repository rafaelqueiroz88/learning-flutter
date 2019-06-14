import 'package:flutter/material.dart';

import './products.dart';

class ProductsManagePage extends StatelessWidget {

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
                title: Text('Ver Produtos'),
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (BuildContext context) => ProductsPage(),),
                  );
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("Gerenciar Produtos"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: 'Novo Produto',),
              Tab(text: 'Todos Produtos',),
            ],
          ),
        ),
        body: Center(
          child: Text('Gestão de produtos'),
        ),
      ),);
  }
}