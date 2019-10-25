import 'package:flutter/material.dart';

class AddressDefault extends StatelessWidget {

  final String address;

  AddressDefault(this.address);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 4.0
      ),
      child: Text(address.toString()),
    );
  }
}