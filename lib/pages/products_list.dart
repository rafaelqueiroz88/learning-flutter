import 'package:flutter/material.dart';
import 'package:flutter_course/pages/product_edit.dart';
// import 'package:flutter_course/pages/product_create.dart';

import '../models/product.dart';

class ProductsListPage extends StatelessWidget {

  final Function updateProduct;
  final Function deleteProduct;
  final List<Product> products;

  ProductsListPage(this.products, this.updateProduct, this.deleteProduct);

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {

        return Dismissible(
          key: Key(products[index].title),
          onDismissed: (DismissDirection direction) {
            /**
             * Exemplos de captura da ação de deslizar os widgets
             * Os exemplos ficaram comentados mas não serão utilizados
             */
            // da esquerda para a direita (ou do início ao fim)
            if (direction == DismissDirection.endToStart) {
              deleteProduct(index);
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
                  backgroundImage: AssetImage(products[index].image),
                ),
                title: Text(products[index].title),
                subtitle: Text('\$${products[index].price.toString()}'),
                trailing: IconButton(
                  icon: Icon(Icons.edit),

                  /**
                   *
                   */
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) {
                            return ProductEditPage(
                              product: products[index],
                              updateProduct: updateProduct,
                              productIndex: index,
                            );
                          }
                      ),
                    );
                  },
                ),
              ),
              Divider(),
            ],
          ),
        );
      },
      itemCount: products.length,
    );
  }
}