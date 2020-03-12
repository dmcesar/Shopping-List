import 'package:flutter/material.dart';
import 'package:mini_projeto/data/product.dart';

class ProductFormScreen extends StatefulWidget {

  final Product product;
  final String title;

  ProductFormScreen({Key key, this.product, this.title = "Add Product"}) : super(key: key);

  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
      home: Scaffold(
        appBar: AppBar(
            title: Text(
              widget.product != null ? widget.product.name : widget.title
            )
        ),

        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),

        body: Container(),
      )
    );
  }
}