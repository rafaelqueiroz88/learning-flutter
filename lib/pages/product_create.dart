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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(40.0),
      child: ListView(
      children: <Widget>[

        TextField(
          autofocus: true,
          decoration: InputDecoration(
            labelText: 'Product Title',
          ),
          onChanged: (String titleValue) {
            setState(() {
              _title = titleValue;
            });
          },
        ),

        TextField(
          maxLines: 4,
          decoration: InputDecoration(
            labelText: 'Product Description',
          ),
          onChanged: (String descriptionValue) {
            setState(() {
              _description = descriptionValue;
            });
          },
        ),

        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Product Price',
          ),
          onChanged: (String priceValue) {
            setState(() {
              _price = double.parse(priceValue);
            });
          },
        ),
        SizedBox(
          height: 10.0,
        ),
        RaisedButton(
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
          Navigator.pushReplacementNamed(context, '/');
        },)
      ],
    ),);
  }
}