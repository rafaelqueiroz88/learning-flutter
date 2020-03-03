import 'package:flutter/material.dart';
import 'dart:async';

import 'package:scoped_model/scoped_model.dart';

import '../scoped-models/main.dart';

enum AuthMode {
  Signup,
  Login
}

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {

  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'acceptTerms': false
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;

  DecorationImage _buildBackgroundImage() {

    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
      image: AssetImage('assets/background.jpg'),
    );
  }

  Widget _buildEmailTextField() {

    return TextFormField(
      decoration: InputDecoration(
        labelText: 'E-Mail',
        filled: true,
        fillColor: Colors.white
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {

        if (
          value.isEmpty
            ||
          !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) { // if starting here
          return 'Please enter a valid email';
        }
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {

    return TextFormField(
      decoration: InputDecoration(labelText: 'Password', filled: true, fillColor: Colors.white),
      obscureText: true,
      controller: _passwordController,
      validator: (String value) {

        if (value.isEmpty || value.length < 6) {
          return 'Password invalid';
        }
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildPasswordConfirmTextField() {

    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Password', filled: true, fillColor: Colors.white),
      obscureText: true,
      validator: (String value) {

        if (_passwordController.text != value) {
          return 'Password invalid';
        }
      },
    );
  }

  Widget _buildAcceptSwitch() {

    return SwitchListTile(
      value: _formData['acceptTerms'],
      onChanged: (bool value) {

        setState(() {
          _formData['acceptTerms'] = value;
        });
      },
      title: Text('Accept Terms'),
    );
  }

  void _submitForm(Function login, Function signUp) async {

    if (!_formKey.currentState.validate() || !_formData['acceptTerms']) {
      return;
    }

    _formKey.currentState.save();

    if (_authMode == AuthMode.Login) {
      login(_formData['email'], _formData['password']);
    }
    else {
      final Map<String, dynamic> successInformation = await signUp(_formData['email'], _formData['password']);
      print('Teste');
      if(successInformation['success'])
        Navigator.pushReplacementNamed(context, '/products');
    }
  }

  /**
   * Main screen scaffold here
   */
  @override
  Widget build(BuildContext context) {

    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: _buildBackgroundImage(),
        ),
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: targetWidth,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    _buildEmailTextField(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildPasswordTextField(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _authMode == AuthMode.Signup ? _buildPasswordConfirmTextField() : Container(),
                    _buildAcceptSwitch(),
                    FlatButton(
                      child: Text(
                        '${_authMode == AuthMode.Login ? 'Não possui conta?\nToque aqui e CADASTRE-SE'
                            :
                        'Já possui uma conta?\nToque aqui e ACESSE'}', textAlign: TextAlign.center,
                      ),
                      onPressed: () {
                        _formData['email'] = null;
                        _formData['password'] = null;
                        _formData['accept_terms'] = false;
                        setState(() {
                          _authMode = _authMode == AuthMode.Login ? AuthMode.Signup : AuthMode.Login;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ScopedModelDescendant<MainModel>(
                      builder: (BuildContext context, Widget child,
                          MainModel model) {
                        return RaisedButton(
                          textColor: Colors.white,
                          child: Text('${_authMode == AuthMode.Login ? 'Login' : 'Cadastrar'}'),
                          onPressed: () => _submitForm(model.login, model.signUp),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
