import 'package:flutter_course/scoped-models/users_products.dart';
import 'package:scoped_model/scoped_model.dart';

import './users_products.dart';
import './user.dart';
import './products.dart';

class MainModel extends Model with UsersProductsModel, UserModel, ProductsModel {}