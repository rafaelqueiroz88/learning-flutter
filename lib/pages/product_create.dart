import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {

  final Function addProduct;

  ProductCreatePage(this.addProduct);

  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePage();
  }
}

class _ProductCreatePage extends State<ProductCreatePage> {

  String _title;
  String _description;
  double _price;
  bool _acceptTerms = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitForm() {
    _formKey.currentState.save();
    final Map<String, dynamic> product = {
      'title': _title,
      'description': _description,
      'price': _price,
      'image': 'assets/food.jpg'
    };
    widget.addProduct(product);
    Navigator.pushReplacementNamed(context, '/products');
  }

  Widget _buildTitleTextField() {
    return TextFormField(
      autofocus: true,
      decoration: InputDecoration(
        labelText: 'Product Title',
      ),
      onSaved: (String value) {
        setState(() {
          _title = value;
        });
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextFormField(
      maxLines: 4,
      decoration: InputDecoration(
        labelText: 'Product Description',
      ),
      onSaved: (String value) {
        setState(() {
          _description = value;
        });
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Product Price',
      ),
      onSaved: (String value) {
        setState(() {
          _price = double.parse(value);
        });
      },
    );
  }

  Widget _buildSubmitButton() {
    return RaisedButton(
      child: ListTile(
        leading: Icon(Icons.save),
        title: Text('Armazenar', style: TextStyle(color: Colors.white,),),
      ),
      // Cor personalizada, como está comentado, a cor padrão será a que foi definida em main.dart
      // color: Theme.of(context).accentColor,
      onPressed: () {
        final Map<String, dynamic> product = {
          'title': _title,
          'description': _description,
          'price': _price,
          'image': 'assets/food.jpg',
        };
        widget.addProduct(product);
        Navigator.pushReplacementNamed(context, '/products');
    },);

    /**
     * Exemplo de uso do GestureDetector
     * Esta widget permite chamadas de ações, eventos, métodos através de propriedades como onTap
     */
//    return GestureDetector(
//      // Com o GesturDetector é possível fazer chamada em eventos como onTap, e neste, informar métodos
//      // onTap: _submit_method,
//      child: Container(
//        color: Colors.green,
//        padding: EdgeInsets.all(5.0),
//        child: Text('Novo Botão'),
//      ),
//    );

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(40.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[

            _buildTitleTextField(),
            _buildDescriptionTextField(),
            _buildPriceTextField(),

            SizedBox( height: 10.0, ),

            _buildSubmitButton(),

          ],
        ),
      ),
    );
  }
}