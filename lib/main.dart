import 'package:flutter/material.dart';
import 'package:flutter_course/pages/auth.dart';
import 'package:flutter_course/pages/products.dart';

import 'package:scoped_model/scoped_model.dart';

// Renderizando erros em tela
// import 'package:flutter/rendering.dart';

import './pages/product.dart';
import './pages/products_manager.dart';

import './scoped-models/main.dart';

import './models/product.dart';

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

    return ScopedModel<MainModel>(
      model: MainModel(),
      child: MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.orange,
            accentColor: Colors.orangeAccent,
            buttonColor: Colors.orange
        ),
        routes: {
          // '/': (BuildContext context) => ProductsPage(_products),
          '/': (BuildContext context) => AuthPage(),
          '/products': (BuildContext context) => ProductsPage(),
          '/admin': (BuildContext context) => ProductsManagePage(),
        },
        onGenerateRoute: (RouteSettings settings) {

          final List<String> pathElements = settings.name.split('/');
          if(pathElements[0] != '')
            return null;

          if(pathElements[1] == 'product') {
            final int index = int.parse(pathElements[2]);
            return MaterialPageRoute<bool>(
                builder: (BuildContext context) => ProductPage(index)
            );
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => ProductsPage()
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