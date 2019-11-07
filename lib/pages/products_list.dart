import 'package:flutter/material.dart';
import 'package:flutter_course/pages/product_edit.dart';
import 'package:flutter_course/pages/product_create.dart';

class ProductsListePage extends StatelessWidget {

  final Function updateProduct;
  final List<Map<String, dynamic>> products;

  ProductsListePage(this.products, this.updateProduct);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Image.asset(products[index]['image']),
          title: Text(products[index]['title']),
          trailing: IconButton(
            icon: Icon(Icons.edit),
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
        );
      },
      itemCount: products.length,
    );
  }
}