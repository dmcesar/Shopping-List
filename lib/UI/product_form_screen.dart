import 'package:flutter/material.dart';
import 'package:mini_projeto/blocs/form_bloc.dart';
import 'package:mini_projeto/data/product.dart';

class ProductForm extends StatefulWidget {

  final FormBloc bloc;
  final Product product;

  ProductForm({Key key, this.bloc, this.product}) : super(key: key);

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {

  Product _toSubmit;

  Column emptyForm() {

    return Column(

    );
  }

  Column editForm() {

    return Column(


    );
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(

      appBar:  AppBar(
        title:  Text(
          this.widget.product == null ? "New product" : this.widget.product.name,
        ),

        actions: <Widget>[
           IconButton(
               icon: const Icon(Icons.save),
               onPressed: () => this.widget.bloc.onSubmit(this._toSubmit)
               ),
        ],
      ),
        body:  (this.widget == null) ? emptyForm() : editForm(),
    );
  }
}