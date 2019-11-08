import 'package:flutter/material.dart';

import '../widgets/helpers/ensure_visible_widget.dart';

class ProductEditPage extends StatefulWidget {

  final Function addProduct;
  final Function updateProduct;
  final int productIndex;
  final Map<String, dynamic> product;

  ProductEditPage({this.addProduct, this.updateProduct, this.product, this.productIndex});

  @override
  State<StatefulWidget> createState() {
    return _ProductEditPage();
  }
}

class _ProductEditPage extends State<ProductEditPage> {

  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/food.jpg'
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleFocusNode = FocusNode();

  /**
   * Ao invocar tocar o botão de envio, o formulário será validado aqui
   */
  void _submitForm() {

    if (!_formKey.currentState.validate())
      return ;

    _formKey.currentState.save();

    if(widget.product == null) {
      widget.addProduct(_formData);
    }
    else {
      widget.updateProduct(widget.productIndex, _formData);
    }

    Navigator.pushReplacementNamed(context, '/products');
  }

  /**
   * Construindo o widget para gerar o campo de texto do título
   */
  Widget _buildTitleTextField() {
    return EnsureVisibleWhenFocused(
      focusNode: _titleFocusNode,
      child: TextFormField(
        focusNode: _titleFocusNode,
        autofocus: true,
        validator: (String value) {
          if(value.isEmpty || value.length < 5)
            return 'É necessário informar um título e precisa ter mais que 5 caracteres';
        },
        initialValue: widget.product == null ? '' : widget.product['title'],
        decoration: InputDecoration(
          labelText: 'Product Title',
        ),
        onSaved: (String value) {
          _formData['title'] = value;
        },
      ),
    );
  }

  /**
   * Construindo o widget para gerar o campo de texto do descrição
   */
  Widget _buildDescriptionTextField() {
    return TextFormField(
      maxLines: 4,
      validator: (String value) {
        if(value.isEmpty || value.length <= 10)
          return 'É necessário informar uma descrição com pelo menos 10 ou mais caracteres';
      },
      initialValue: widget.product == null ? '' : widget.product['description'],
      decoration: InputDecoration(
        labelText: 'Product Description',
      ),
      onSaved: (String value) {
        _formData['description'] = value;
      },
    );
  }

  /**
   * Construindo o widget para gerar o campo de texto do preço
   */
  Widget _buildPriceTextField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      validator: (String value) {
        if(value.isEmpty || !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value))
          return 'É necessário informar um preço e este precisa ser um número';
      },
      decoration: InputDecoration(
        labelText: 'Product Price',
      ),
      initialValue: widget.product == null ? '' : widget.product['price'].toString(),
      /**
       * O método setState não é mais necessário, mais deixei aqui para exemplificar como ficava
       */
      onSaved: (String value) {
        setState(() {
          _formData['price'] = double.parse(value);
        });
      },
    );
  }

  /**
   * Construindo o widget para gerar o botão de envio
   */
  Widget _buildSubmitButton() {
    return RaisedButton(
      child: ListTile(
        leading: Icon(Icons.save),
        title: Text(
          'Armazenar',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      // Cor personalizada, como está comentado, a cor padrão será a que foi definida em main.dart
      // color: Theme.of(context).accentColor,
      onPressed: _submitForm,
    );

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

  /**
   * Construindo o corpo da tab que cadastra produto
   * Neste método os métodos acima serão invocados
   */
  @override
  Widget build(BuildContext context) {

    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    final Widget pageContent = GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(40.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
            children: <Widget>[

              /**
               * Funções declaradas acima
               */
              _buildTitleTextField(),
              _buildDescriptionTextField(),
              _buildPriceTextField(),

              SizedBox( height: 10.0, ),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );

    return widget.product == null ? pageContent : Scaffold(appBar: AppBar(title: Text('Add Product'),), body: pageContent,);
  }
}