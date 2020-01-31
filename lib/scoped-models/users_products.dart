import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../models/user.dart';

mixin UsersProductsModel on Model {

  /**
   *  Utilizamos underscore (ou underline) para indicar que esta propriedade é inacessível de fora da classe
   */
  User authenticatedUser;
  List<Product> products = [];
  int chosedProductIndex;

  void addProduct(String title, String description, String image, double price) {
    final Product newProduct = Product(
        title: title,
        description: description,
        image: image,
        price: price,
        userEmail: authenticatedUser.email,
        userId: authenticatedUser.id
    );
    products.add(newProduct);
    chosedProductIndex = null;
    notifyListeners();
  }
}