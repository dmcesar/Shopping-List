import 'package:flutter/material.dart';
import 'package:mini_projeto/data/product.dart';

class ProductForm extends StatefulWidget {

  final Product product;
  final String title;

  ProductForm({Key key, this.product, this.title = "Add Product"}) : super(key: key);

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      theme: ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),

      home: Scaffold(

        appBar: AppBar(

            title: Text(
                widget.product != null ? widget.product.name : widget.title
            ),
        ),

        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),

        body: Form(
          child: ListView(

          )
        )
      )
    );
  }
}