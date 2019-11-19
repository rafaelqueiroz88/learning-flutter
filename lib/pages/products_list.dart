import 'package:flutter/material.dart';
import 'package:flutter_course/pages/product_edit.dart';
//import 'package:flutter_course/pages/product_create.dart';

class ProductsListPage extends StatelessWidget {

  final Function updateProduct;
  final List<Map<String, dynamic>> products;

  ProductsListPage(this.products, this.updateProduct);

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {

        return Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(products[index]['image']),
              ),
              title: Text(products[index]['title']),
              subtitle: Text('\$${products[index]['price'].toString()}'),
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
        );
      },
      itemCount: products.length,
    );
  }
}