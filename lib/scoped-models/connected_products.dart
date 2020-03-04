import 'dart:convert';
import 'dart:async';

import 'package:rxdart/subjects.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

/**
 * Utilizado para armazenar dados de pequeno porte direto no dispositivo
 */
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth.dart';
import '../models/product.dart';
import '../models/user.dart';

mixin ConnectedProductsModel on Model {
  List<Product> _products = [];
  String _selProductId;
  User _authenticatedUser;
  bool _isLoading = false;
}

mixin ProductsModel on ConnectedProductsModel {

  bool _showFavorites = false;

  List<Product> get allProducts {
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    if (_showFavorites) {
      return _products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(_products);
  }

  int get selectedProductIndex {
    return _products.indexWhere((Product product) {
      return product.id == _selProductId;
    });
  }

  String get selectedProductId {
    return _selProductId;
  }

  Product get selectedProduct {
    if (selectedProductId == null) {
      return null;
    }

    return _products.firstWhere((Product product) {
      return product.id == _selProductId;
    });
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  Future<bool> addProduct(String title, String description, String image, double price) async {

    _isLoading = true;
    notifyListeners();

    try {

      final Map<String, dynamic> productData = {
        'title': title,
        'description': description,
        'image': 'https://upload.wikimedia.org/wikipedia/commons/6/68/Chocolatebrownie.JPG',
        'price': price,
        'userEmail': _authenticatedUser.email,
        'userId': _authenticatedUser.id
      };

      final http.Response response = await http.post(
        'https://learning-flutter-70f77.firebaseio.com/products.json?auth=${_authenticatedUser.token}',
        body: json.encode(productData)
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final Map<String, dynamic> responseData = json.decode(response.body);

      final Product newProduct = Product(
          id: responseData['name'],
          title: title,
          description: description,
          image: image,
          price: price,
          userEmail: _authenticatedUser.email,
          userId: _authenticatedUser.id);

      _products.add(newProduct);
      _isLoading = false;
      notifyListeners();
      return true;
    }
    catch(error) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<Null> updateProduct(String title, String description, String image, double price) {

    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> updateData = {
      'title': title,
      'description': description,
      'image': 'https://upload.wikimedia.org/wikipedia/commons/6/68/Chocolatebrownie.JPG',
      'price': price,
      'userEmail': selectedProduct.userEmail,
      'userId': selectedProduct.userId
    };

    return http.put(
      'https://learning-flutter-70f77.firebaseio.com/products/${selectedProduct.id}.json?auth=${_authenticatedUser.token}',
      body: json.encode(updateData)
    ).then((http.Response response) {
      _isLoading = false;
      final Product updatedProduct = Product(
        id: selectedProduct.id,
        title: title,
        description: description,
        image: image,
        price: price,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId);
      _products[selectedProductIndex] = updatedProduct;
      notifyListeners();
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  void deleteProduct() {

    _isLoading = true;
    final deletedProductId = selectedProduct.id;
    _products.removeAt(selectedProductIndex);
    _selProductId = null;
    notifyListeners();
    http.delete('https://learning-flutter-70f77.firebaseio.com/products/${deletedProductId}.json?auth=${_authenticatedUser.token}')
        .then((http.Response response) {
      _isLoading = false;
      notifyListeners();
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<Null> fetchProducts() {

    _isLoading = true;
    notifyListeners();

    return http
        .get('https://learning-flutter-70f77.firebaseio.com/products.json?auth=${_authenticatedUser.token}')
        .then((http.Response response) {
      final List<Product> fetchedProductList = [];
      final Map<String, dynamic> productListData = json.decode(response.body);

      if (productListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      productListData.forEach((String productId, dynamic productData) {
        final Product product = Product(
          id: productId,
          title: productData['title'],
          description: productData['description'],
          image: productData['image'],
          price: productData['price'],
          userEmail: productData['userEmail'],
          userId: productData['userId']);
        fetchedProductList.add(product);
      });

      _products = fetchedProductList;
      _isLoading = false;
      notifyListeners();
      _selProductId = null;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  void toggleProductFavoriteStatus() {

    final bool isCurrentlyFavorite = selectedProduct.isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    final Product updatedProduct = Product(
      id: selectedProduct.id,
      title: selectedProduct.title,
      description: selectedProduct.description,
      price: selectedProduct.price,
      image: selectedProduct.image,
      userEmail: selectedProduct.userEmail,
      userId: selectedProduct.userId,
      isFavorite: newFavoriteStatus);
    _products[selectedProductIndex] = updatedProduct;
    notifyListeners();
  }

  void selectProduct(String productId) {
    _selProductId = productId;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}

mixin UserModel on ConnectedProductsModel {

  Timer _authTimer;
  PublishSubject<bool> _userSubject = PublishSubject();

  PublishSubject<bool> get userSubject {
    return _userSubject;
  }

  User get user {
    return _authenticatedUser;
  }

  Future<Map<String, dynamic>> authenticate(String email, String password, [AuthMode mode = AuthMode.Login]) async {

    // _authenticatedUser = User(id: 'fdalsdfasf', email: email, password: password);
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    http.Response response;
    String uri;

    if (mode == AuthMode.Login)
      uri = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBaFAi82LFLKIqNI6gqJVAwev3MTxn9ShM';
    else
      uri = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBaFAi82LFLKIqNI6gqJVAwev3MTxn9ShM';

    response = await http.post(
        uri,
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'}
    );
    final Map<String, dynamic> responseData = json.decode(response.body);

    bool hasError = true;
    String message = 'Something went wrong';

    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'Authentication succeeded';

      /**
       * Armazenando o token em memória
       */
      _authenticatedUser = User(id: responseData['localId'], email: email, token: responseData['idToken']);

      setAuthTimeout(int.parse(responseData['expiresIn']));
      _userSubject.add(true);

      final DateTime now = DateTime.now();
      final DateTime expiryTime = now.add(Duration(seconds: int.parse(responseData['expiresIn'])));

      /**
       * Armazenando o token no dispositivo
       */
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', responseData['idToken']);
      prefs.setString('userEmail', email);
      prefs.setString('userId', responseData['localId']);
      prefs.setString('expiryTime', expiryTime.toIso8601String());
    }
    else if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
      message = 'This e-mail was not found';
    }
    else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
      message = 'This e-mail already exists';
    }
    else if (responseData['error']['message'] == 'INVALID_EMAIL') {
      message = 'This e-mail address is invalid';
    }
    else if (responseData['error']['message'] == 'INVALID_PASSWORD') {
      message = 'Invalid password';
    }

    _isLoading = false;
    notifyListeners();

    return {'success': !hasError, 'message': message};
  }

  void autoAuth() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    final String expiryTime = prefs.getString('expiryTime');

    if (token != null) {

      final DateTime now = DateTime.now();
      final parsedExpiryTime = DateTime.parse(expiryTime);

      if(parsedExpiryTime.isBefore(now)) {
        _authenticatedUser = null;
        notifyListeners();
        return ;
      }

      final String userEmail = prefs.getString('userEmail');
      final String userId = prefs.getString('userId');
      final tokenLifeSpan = parsedExpiryTime.difference(now).inSeconds;

      _userSubject.add(true);
      setAuthTimeout(tokenLifeSpan);
      _authenticatedUser = User(id: userId, email: userEmail, token: token);

      notifyListeners();
    }
  }

  void logout() async {

    _authenticatedUser = null;
    _authTimer.cancel();

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    /**
     * No caso é possível utilizar para fazer a limpeza dos dados no dispositivo
     * as opções .clear()
     * ou remove('key')
     * Caso somente algumas informações devam ser apagadas utilize remove e
     * informe quais.
     * Caso tudo possa ser apagado utilize clear
     */
    // prefs.clear();
    prefs.remove('token');
    prefs.remove('userEmail');
    prefs.remove('userId');
  }

  void setAuthTimeout(int time) {

    _authTimer = Timer(Duration(seconds: time), () {
      logout();
      _userSubject.add(false);
    });
  }
}

mixin UtilityModel on ConnectedProductsModel {

  bool get isLoading {
    return _isLoading;
  }
}