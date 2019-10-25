import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  String _email;
  String _password;
  bool _acceptTerms = false;

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.5), BlendMode.dstATop
      ),
      image: AssetImage('assets/background.jpg'),
    );
  }

  Widget _buildEmailTextField() {
    return TextField(
      autofocus: true,
      decoration: InputDecoration(
        labelText: 'E-mail',
        filled: true,
        fillColor: Colors.white,
      ),
      onChanged: (String value) {
        setState(() {
          _email = value;
        });
      },
    );
  }

  Widget _buildSenhaTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Senha',
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: true,
      onChanged: (String value) {
        setState(() {
          _password = value;
        });
      },
    );
  }

  Widget _buildTermsSwitch() {
    return SwitchListTile(
      value: _acceptTerms, title: Text('Aceitar os termos de uso', style: TextStyle(color: Colors.white,),), onChanged: (bool value) {
        setState(() {
          _acceptTerms = value;
        });
      },
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return RaisedButton(
      child: Text('Entrar'),
      // color: Colors.redAccent,
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/products');
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    /**
     * Pega a largura atual do dispositivo em tempo de execução sujeito a mudanças na orientação da tela
     */
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double width = deviceWidth > 768.0 ? 500.0 : deviceWidth * 0.75;

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: _buildBackgroundImage(),
        ),
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: width,
              child: Column(
                children: <Widget>[

                  _buildEmailTextField(),

                  SizedBox(
                    height: 10.0,
                  ),

                  _buildSenhaTextField(),

                  SizedBox(
                    height: 10.0,
                  ),

                  _buildTermsSwitch(),

                  _buildSubmitButton(context),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}