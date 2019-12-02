import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';

class ProductsModel extends Model {

  List<Product> _products = [];

  int _selectedProduct;

  List<Product> get products {
    return List.from(_products);
  }

  int get selectProductIndex {
    return _selectedProduct;
  }

  Product get selectedProduct {
    if (_selectedProduct == null)
      return null;
    return _products[_selectedProduct];
  }

  void addProduct(Product product) {
    print(_products);
    _products.add(product);
    _selectedProduct = null;
  }

  void updateProduct(int index, Product product) {
    _products[_selectedProduct] = product;
    _selectedProduct = null;
  }

  void deleteProduct() {
    _products.removeAt(_selectedProduct);
  }

  void selectProduct(int index) {
    _selectedProduct = index;
  }
}