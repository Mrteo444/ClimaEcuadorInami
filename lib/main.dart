import 'package:ecuador_clima/ui/get_started.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      title: 'Weather App',
      home: GetStarted(),
      debugShowCheckedModeBanner: false,
    );
  }
}


