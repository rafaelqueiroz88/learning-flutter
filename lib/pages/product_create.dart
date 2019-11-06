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

  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/food.jpg'
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /**
   * Ao invocar tocar o botão de envio, o formulário será validado aqui
   */
  void _submitForm() {

    if (!_formKey.currentState.validate())
      return ;

    _formKey.currentState.save();

    widget.addProduct(_formData);
    Navigator.pushReplacementNamed(context, '/products');
  }

  /**
   * Construindo o widget para gerar o campo de texto do título
   */
  Widget _buildTitleTextField() {
    return TextFormField(
      autofocus: true,
      validator: (String value) {
        if(value.isEmpty || value.length < 5)
          return 'É necessário informar um título e precisa ter mais que 5 caracteres';
      },
      decoration: InputDecoration(
        labelText: 'Product Title',
      ),
      onSaved: (String value) {
        _formData['title'] = value;
      },
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(40.0),
        child: Form(
          key: _formKey,
          child: ListView(
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
  }
}