/**
 * Imports
 */
import 'package:flutter/material.dart';
import './products.dart';
import './product_control.dart';

// StatelessWidget foi herdada de material.dart (não utilizado por hora)
// StatefulWidget foi herdada de material.dart

class ProductManager extends StatefulWidget {

  final String startingProduct;

  // Atribuindo um valor padrão, e dizendo para a instancia que o valor a ser passado
  // É o startingProduct, nesse caso
  ProductManager({this.startingProduct});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductManager();
  }
}

// O _ afrente do nome da classe, é uma convenção para classes que não serão chamadas fora desta classe
// e sim, para outra classe dentro do mesmo escopo
class _ProductManager extends State<ProductManager> {

  // O _ frente ao nome da propriedade, é utilizado como convenção quando
  // a propriedade será utilizada somente dentro desta classe
  List<String> _products = [];

  @override
  void initState() {
    // O uso de widget é disponibilizado pela herança de State
    // seu uso permite acessar propriedades da classe informada (no caso ProductManager)
    if(widget.startingProduct != null)
      _products.add(widget.startingProduct);

    super.initState();
  }

  @override
  void didUpdateWidget(ProductManager oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  void _updateProduct(String product) {

    setState(() {  // Função disponibilizada pelo flutter
      print(_products);
      _products.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(children: [Container(
      margin: EdgeInsets.all(10.0),
      child: ProductControl(_updateProduct),
    ),
    Expanded(child: Products(_products)),
    ],);
  }
}