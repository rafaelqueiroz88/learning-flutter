import '../models/user.dart';
import './users_products.dart';

mixin UserModel on UsersProductsModel {

  void login(String email, String password) {
    authenticatedUser = User(id: 'ausdiauhsd', email: email, password: password);
  }
}