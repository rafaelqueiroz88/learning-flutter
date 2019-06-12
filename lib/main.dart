import 'package:flutter/material.dart';

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

// StatelessWidget foi herdada de material.dart (não utilizado por hora)

// StatefulWidget foi herdada de material.dart
class MyApp extends StatefulWidget { 

  @override
  State<StatefulWidget> createState() {
    
    return _MyAppState();
  }
}

// O _ afrente do nome da classe, é uma convenção para classes que não serão chamadas fora desta classe
// e sim, para outra classe dentro do mesmo escopo
class _MyAppState extends State<MyApp> {
  
  // O _ frente ao nome da propriedade, é utilizado como convenção quando
  // a propriedade será utilizada somente dentro desta classe
  List<String> _products = ['Food Tester'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Menu"),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10.0),
              child: RaisedButton(
                onPressed: () {
                  setState(() {  // Função disponibilizada pelo flutter
                    _products.add("Advanced Food tester");
                    print(_products);
                  });
                }, // Chamada anonima (e no caso, função vazia/sem retorno)
                child: Text("Add Product"),
              ),
            ),
            Column(
              children: _products.map((element) => Card(
                child: Column(
                  children: <Widget>[
                    Image.asset("assets/food.jpg"),
                    Text(element),
                  ],
                ),
              ),).toList()
            )
          ],
        ),
      ),
    );
  }
}