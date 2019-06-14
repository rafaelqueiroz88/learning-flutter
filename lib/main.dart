import 'package:flutter/material.dart';

// Renderizando erros em tela
// import 'package:flutter/rendering.dart';

import 'pages/auth.dart';

/**
 * Permite utilizar funções como: debugPaintSizeEnable = true
 * Exibe detalhes estruturais das widgets em tela com marcações sobre as mesmas
 * Ex. espaçamento dos botões, margem e etc...
 */

import './product_manager.dart';

// Método alternativo
// main() {
//   runApp(MyApp()); // Método runApp trazido pelo material.dart
// }

// Quando houver somente uma única chamada dentro de um método, pode ser chamado desta forma
main() => runApp(MyApp());

// class MyApp extends StatelessWidget { // StatelessWidget foi herdada de material.dart

//   build(context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Rafael"),
//         ),
//       ),
//     );
//   }
// }


class MyApp extends StatelessWidget { 

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
      home: AuthPage(),
    );
  }
}