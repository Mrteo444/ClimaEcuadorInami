import 'package:flutter/material.dart';

class Clima extends StatelessWidget {
  final String province;

  const Clima({Key? key, required this.province}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima en $province'),
      ),
      body: Center(
        child: Text(
          'El clima en $province es...',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
