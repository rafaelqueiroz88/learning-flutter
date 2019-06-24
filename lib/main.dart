import 'package:flutter/material.dart';
import 'package:flutter_course/pages/products.dart';

// Renderizando erros em tela
// import 'package:flutter/rendering.dart';

import './pages/product.dart';
import './pages/products_manager.dart';

main() => runApp(MyApp());


class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {

  List<Map<String, String>> _products = [];

  // dynamic poderia ser usado como um tipo genérico, porém, neste caso sabemos
  // qual o tipo do elemento que será passado para o map
  void _addProduct(Map<String, String> product) {

    setState(() {  // Função disponibilizada pelo flutter
      print(_products);
      _products.add(product);
    });
  }

  void _deleteProduct(int index) {

    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Material style properties
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.redAccent,
        // brightness: Brightness.dark,
      ),
      // Material style properties end
      
      // Para que a rota dinamica (identificada por '/') funcione
      // O parametro 'home: chamada()', não pode estar sendo utilizado
      // para evitar erros de redundância.
      // home: AuthPage(),

      // Entendendo como funcionam os esquemas de rota dinâmico
      routes: {
        // '/' é o endereço especial que significa HOME
        '/': (BuildContext context) => ProductsPage(_products, _addProduct, _deleteProduct),
        // context recortado de products.dart (para compreendimento de como funciona as rotas)
        '/admin': (BuildContext context) => ProductsManagePage(),        
      },
      onGenerateRoute: (RouteSettings settings) {
        
        final List<String> pathElements = settings.name.split('/');
        if(pathElements[0] != '')
          return null;
        
        if(pathElements[1] == 'product') {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => ProductPage(_products[index]['title'], _products[index]['image'])
          );
        }

        return null;        
      },
    );
  }
}