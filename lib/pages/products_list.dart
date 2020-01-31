import 'package:flutter/material.dart';
import 'package:flutter_course/pages/product_edit.dart';

import 'package:scoped_model/scoped_model.dart';

import '../scoped-models/main.dart';

class ProductsListPage extends StatefulWidget {

  final MainModel model;

  ProductsListPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _ProductsListPageState();
  }
}

class _ProductsListPageState extends State<ProductsListPage> {

  @override
  initState() {
    widget.model.fetchProducts();
    super.initState();
  }

  Widget _buildEditButton(BuildContext context, int index, MainModel model) {
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
        ).then((_) {
          model.selectProduct(null);
        });
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {

            return Dismissible(
              key: Key(model.allProducts[index].title),
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
                      backgroundImage: NetworkImage(model.allProducts[index].image),
                      // AssetImage deve ser usado para uma fonte local de imagem
                      // backgroundImage: AssetImage(model.allProducts[index].image),
                    ),
                    title: Text(model.allProducts[index].title),
                    subtitle: Text('\$${model.allProducts[index].price.toString()}'),
                    trailing: _buildEditButton(context, index, model),
                  ),
                  Divider(),

                ],
              ),
            );
          },
          itemCount: model.allProducts.length,
        );
      },
    );
  }
}