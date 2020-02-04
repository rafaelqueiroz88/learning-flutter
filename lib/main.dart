import 'package:flutter/material.dart';
import 'package:flutter_course/pages/auth.dart';
import 'package:flutter_course/pages/products.dart';

import 'package:scoped_model/scoped_model.dart';

// Renderizando erros em tela
// import 'package:flutter/rendering.dart';

import './pages/product.dart';
import './pages/products_manager.dart';
import './models/product.dart';
import './scoped-models/main.dart';

void main() {

  /**
   * Os recursos abaixo dependem do rendering.dart, descomente-os para debbugar
   */
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {

  @override
  Widget _buildMain(BuildContext context) {

    final MainModel model = MainModel();
    return ScopedModel<MainModel>(
      model: model,
      child: MaterialApp(
        theme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.blue,
            accentColor: Colors.blueAccent,
            buttonColor: Colors.blue
        ),
        routes: {
          // '/': (BuildContext context) => ProductsPage(_products),
          '/': (BuildContext context) => AuthPage(),
          '/products': (BuildContext context) => ProductsPage(model),
          '/admin': (BuildContext context) => ProductsManagePage(model),
        },
        onGenerateRoute: (RouteSettings settings) {

          final List<String> pathElements = settings.name.split('/');
          if(pathElements[0] != '')
            return null;

          if(pathElements[1] == 'product') {

            final String productId = pathElements[2];
            final Product product = model.allProducts.firstWhere((Product product) {
              return product.id == productId;
            });

            model.selectProduct(productId);

            return MaterialPageRoute<bool>(
                builder: (BuildContext context) => ProductPage(product)
            );
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => ProductsPage(model)
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildMain(context);
  }
}