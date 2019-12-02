import 'package:flutter/material.dart';
import 'package:flutter_course/pages/product_edit.dart';
// import 'package:flutter_course/pages/product_create.dart';

import 'package:scoped_model/scoped_model.dart';

import '../scoped-models/products.dart';

class ProductsListPage extends StatelessWidget {

  Widget _buildEditButton(BuildContext context, int index, ProductsModel model) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        model.selectProduct(index);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ProductEditPage();
            },
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsModel>(
      builder: (BuildContext context, Widget child, ProductsModel model) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {

            return Dismissible(
              key: Key(model.products[index].title),
              onDismissed: (DismissDirection direction) {
                /**
                 * Exemplos de captura da ação de deslizar os widgets
                 * Os exemplos ficaram comentados mas não serão utilizados
                 */
                // da esquerda para a direita (ou do início ao fim)
                if (direction == DismissDirection.endToStart) {
                  model.selectProduct(index);
                  model.deleteProduct();
                }
                // da direita para a esquerda (ou do fim para o início)
//            else if (direction == DismissDirection.startToEnd){
//              print('deslizou do início para o fim');
//            }
                // outros (não detectados neste caso)
//            else {
//              print('deslizou em outra direção para outra direção');
//            }
              },
              background: Container(color: Colors.red),
              child: Column(
                children: <Widget>[

                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(model.products[index].image),
                    ),
                    title: Text(model.products[index].title),
                    subtitle: Text('\$${model.products[index].price.toString()}'),
                    trailing: _buildEditButton(context, index, model),
                  ),
                  Divider(),

                ],
              ),
            );
          },
          itemCount: model.products.length,
        );
      },
    );
  }
}