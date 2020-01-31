import 'package:scoped_model/scoped_model.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import '../models/product.dart';
import '../models/user.dart';

mixin UsersProductsModel on Model {

  /**
   *  Utilizamos underscore (ou underline) para indicar que esta propriedade é inacessível de fora da classe
   */
  User _authenticatedUser;
  List<Product> _products = [];
  int _chosedProductIndex;
  bool _isLoading = false;

  Future<Null> addProduct(String title, String description, String image, double price) {

    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      // random image url taken from google haha
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTArBz1vns2tGMQhA_xsl8I3lhCliQuZdVYZbeNKWM5N1VK7cHm',
      'price': price,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id

    };
    return http.post('https://learning-flutter-70f77.firebaseio.com/products.json', body: json.encode(productData))
      .then((http.Response response) {

        final Map<String, dynamic> responseData = json.decode(response.body);
        final Product newProduct = Product(
          id: responseData['name'],
          title: title,
          description: description,
          image: image,
          price: price,
          userEmail: _authenticatedUser.email,
          userId: _authenticatedUser.id
        );
        _products.add(newProduct);
        notifyListeners();
        _isLoading = false;
    });
  }
}

mixin ProductsModel on UsersProductsModel {

  bool _showFavorites = false;

  List<Product> get allProducts {
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    if (_showFavorites)
      return List.from(_products.where((Product product) => product.isFavorite).toList());
    return List.from(_products);
  }

  int get selectProductIndex {
    return _chosedProductIndex;
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  Product get selectedProduct {
    if (_chosedProductIndex == null)
      return null;
    return _products[_chosedProductIndex];
  }

  void fetchProducts() {

    _isLoading = true;
    notifyListeners();

    http.get('https://learning-flutter-70f77.firebaseio.com/products.json')
      .then((http.Response response) {

        final List<Product> fetchedProductsList = [];
        final Map<String, dynamic> productsListData = json.decode(response.body);

        if(productsListData == null) {
          _isLoading = false;
          notifyListeners();
          return;
        }

        productsListData.forEach((String productId, dynamic productData) {
          final Product product = Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            image: productData['image'],
            price: productData['price'],
            userEmail: productData['userEmail'],
            userId: productData['userId']
          );
          fetchedProductsList.add(product);
        });

        _products = fetchedProductsList;
        notifyListeners();
        _isLoading = false;
    });
  }

  void toggleProductFavorite() {
    final bool favoriteStatus = selectedProduct.isFavorite;
    final bool newFavoriteStatus = !favoriteStatus;
    final Product updatedProduct = Product(
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId,
        isFavorite: newFavoriteStatus
    );
    _products[_chosedProductIndex] = updatedProduct;
    notifyListeners();
  }

  Future<Null> updateProduct(String title, String description, String image, double price) {

    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> updateData = {
      'title': title,
      'description': description,
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSu0Th9-ZYVBi3bcoVJ1-50XVkQQ1mEXeZo-xiVv9G2yTCwyrYU',
      'price': price,
      'userEmail': selectedProduct.userEmail,
      'userId': selectedProduct.id
    };
    return http.put('https://learning-flutter-70f77.firebaseio.com/products/${selectedProduct.id}.json', body: jsonEncode(updateData))
    .then((http.Response response) {
      _isLoading = false;
      notifyListeners();

      final Product updateProduct = Product(
          id: selectedProduct.id,
          title: title,
          description: description,
          image: image,
          price: price,
          userEmail: selectedProduct.userEmail,
          userId: selectedProduct.userId
      );

      _products[_chosedProductIndex] = updateProduct;
      notifyListeners();
    });
  }

  void deleteProduct() {
    _products.removeAt(_chosedProductIndex);
    notifyListeners();
  }

  void selectProduct(int index) {
    _chosedProductIndex = index;
    if (index != null)
      notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}

mixin UserModel on UsersProductsModel {

  void login(String email, String password) {
    _authenticatedUser = User(id: 'ausdiauhsd', email: email, password: password);
  }
}

mixin UtilityModel on UsersProductsModel {
  bool get isLoading {
    return _isLoading;
  }
}