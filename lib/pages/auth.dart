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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      backgroundColor: Colors.redAccent,
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[

            TextField(
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'E-mail',
              ),
              onChanged: (String value) {
                setState(() {
                  _email = value;
                });
              },
            ),

            TextField(
              decoration: InputDecoration(
                labelText: 'Senha',
              ),
              obscureText: true,
              onChanged: (String value) {
                setState(() {
                  _password = value;
                });
              },
            ),

            SizedBox(
              height: 10.0,
            ),
            SwitchListTile(
              value: _acceptTerms, title: Text('Aceitar os termos de uso'), onChanged: (bool value) {
                setState(() {
                  _acceptTerms = value;
                });
              },
            ),
            RaisedButton(
              child: Text('Entrar'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/products');
              },
            ),
          ],
        ),
      ),
    );
  }
}