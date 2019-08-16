import 'package:flutter/material.dart';

import './products.dart';

class AuthPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.redAccent,
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Center(
          child: RaisedButton(
            child: Text('Login'),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ),
      );
  }
}