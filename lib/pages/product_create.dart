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

  Widget _buildTitleTextField() {
    return TextField(
      autofocus: true,
      decoration: InputDecoration(
        labelText: 'Product Title',
      ),
      onChanged: (String titleValue) {
        setState(() {
          _title = titleValue;
        });
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextField(
      maxLines: 4,
      decoration: InputDecoration(
        labelText: 'Product Description',
      ),
      onChanged: (String descriptionValue) {
        setState(() {
          _description = descriptionValue;
        });
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Product Price',
      ),
      onChanged: (String priceValue) {
        setState(() {
          _price = double.parse(priceValue);
        });
      },
    );
  }

  Widget _buildSubmitButton() {
    return RaisedButton(
      child: Text("Salvar"),
      color: Theme.of(context).accentColor,
      textColor: Colors.white,
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(40.0),
      child: ListView(
      children: <Widget>[

        _buildTitleTextField(),
        _buildDescriptionTextField(),
        _buildPriceTextField(),

        SizedBox( height: 10.0, ),

        _buildSubmitButton(),

      ],),);
  }
}