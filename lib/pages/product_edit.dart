import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped-models/main.dart';
import '../widgets/helpers/ensure_visible_widget.dart';
import '../models/product.dart';

class ProductEditPage extends StatefulWidget {

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
   * Construindo o widget para gerar o botão de envio
   */
  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model) {
      print('AQUI ${model.selectedProductIndex}');
      return model.isLoading ? Center(child: CircularProgressIndicator(),) : RaisedButton(
        child: ListTile(
          leading: Icon(Icons.save),
          title: Text('Armazenar',
            style: TextStyle(color: Colors.white,),
          ),
        ),

        // Cor personalizada, como está comentado, a cor padrão será a que foi definida em main.dart
        // color: Theme.of(context).accentColor,
        onPressed: () => _submitForm(model.addProduct, model.updateProduct, model.selectProduct, model.selectedProductIndex),
      );
    });

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
   * Ao invocar tocar o botão de envio, o formulário será validado aqui
   */
  void _submitForm(
      Function addProduct,
      Function updateProduct,
      Function setSelectedProduct,
      [int selectedProductIndex]) {

    if (!_formKey.currentState.validate())
      return ;

    _formKey.currentState.save();
    if(selectedProductIndex == -1) {
      addProduct(
        _formData['title'],
        _formData['description'],
        _formData['image'],
        _formData['price'],
      ).then((bool success) {
        if (success) {
          Navigator.pushReplacementNamed(context, '/products')
          .then((_) => setSelectedProduct(null));
        }
        else {
          showDialog(context: context, builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Something went wrong'),
              content: Text('Looks like you have a low connection'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Ok')
                ),

              ],
            );
          });
        }
      });
    }
    else {
      updateProduct(
        _formData['title'],
        _formData['description'],
        _formData['image'],
        _formData['price'],
      ).then((_) => Navigator.pushReplacementNamed(context, '/products').then((_) => setSelectedProduct(null)));
    }
  }

  /**
   * Construindo o widget para gerar o campo de texto do título
   */
  Widget _buildTitleTextField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _titleFocusNode,
      child: TextFormField(
        focusNode: _titleFocusNode,
        autofocus: true,
        validator: (String value) {
          if(value.isEmpty || value.length < 5)
            return 'É necessário informar um título e precisa ter mais que 5 caracteres';
        },
        initialValue: product == null ? '' : product.title,
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
  Widget _buildDescriptionTextField(Product product) {
    return TextFormField(
      maxLines: 4,
      validator: (String value) {
        if(value.isEmpty || value.length <= 10)
          return 'É necessário informar uma descrição com pelo menos 10 ou mais caracteres';
      },
      initialValue: product == null ? '' : product.description,
      decoration: InputDecoration(
        labelText: 'Product Description',
      ),
      onSaved: (String value) {
        _formData['description'] = value;
      },
    );
  }

  Widget _buildPageContent(BuildContext context, Product product) {

    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    return GestureDetector(
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
              _buildTitleTextField(product),
              _buildDescriptionTextField(product),
              _buildPriceTextField(product),

              SizedBox( height: 10.0, ),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  /**
   * Construindo o widget para gerar o campo de texto do preço
   */
  Widget _buildPriceTextField(Product product) {
    return TextFormField(
      keyboardType: TextInputType.number,
      validator: (String value) {
        if(value.isEmpty || !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value))
          return 'É necessário informar um preço e este precisa ser um número';
      },
      decoration: InputDecoration(
        labelText: 'Product Price',
      ),
      initialValue: product == null ? '' : product.price.toString(),
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
   * Construindo o corpo da tab que cadastra produto
   * Neste método os métodos acima serão invocados
   */
  @override
  Widget build(BuildContext context) {

    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model) {

      final Widget pageContent = _buildPageContent(context, model.selectedProduct);

      // a comparação é feita com menos um, uma vez que o método
      // selectedProductId.indexWhere retorna -1 caso um registro não seja encontrado
      return model.selectedProductIndex == -1
        ? pageContent
        : Scaffold(
          appBar: AppBar(title: Text('Edit Product'),),
          body: pageContent,
        );
    });
  }
}