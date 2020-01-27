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

  void toggleProductFavorite() {
    final bool favoriteStatus = selectedProduct.isFavorite;
    final bool newFavoriteStatus = !favoriteStatus;
    final Product updatedProduct = Product(
      title: selectedProduct.title, 
      description: selectedProduct.description, 
      price: selectedProduct.price, 
      image: selectedProduct.image,
      isFavorite: newFavoriteStatus 
    );
    _products[_selectedProduct] = updatedProduct;
    _selectedProduct = null;
    notifyListeners();
  }

  void addProduct(Product product) {
    print(_products);
    _products.add(product);
    _selectedProduct = null;
    notifyListeners();
  }

  void updateProduct(int index, Product product) {
    _products[_selectedProduct] = product;
    _selectedProduct = null;
    notifyListeners();
  }

  void deleteProduct() {
    _products.removeAt(_selectedProduct);
    notifyListeners();
  }

  void selectProduct(int index) {
    _selectedProduct = index;
  }
}