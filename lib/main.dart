import 'package:flutter/material.dart';
import 'package:mini_projeto/Product.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iQueChumbo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  MyHomePage({Key key, this.title = "Shopping List"}) : super(key: key);

  final String title;

  final products = List<Product>.generate(
    6, /* Number of objects to generate */
      (i) => Product(
          "image$i", /* Image URL */
          Product.productNames[i], /* Product name from defaults list */
          i, /* Number of items to buy */
          "Must buy $i", /* Product description */
          (7 - i).toDouble() /* Unit price */
      )
  );

  @override
  Widget build(BuildContext context) {

    return null;
  }
}
