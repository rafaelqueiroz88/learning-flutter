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
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3), BlendMode.dstATop
            ),
            image: AssetImage('assets/background.jpg'),
          ),
        ),
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[

                TextField(
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
                ),

                SizedBox(
                  height: 10.0,
                ),

                TextField(
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
                  color: Colors.redAccent,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/products');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}