import 'package:flutter/material.dart';
import 'package:mini_projeto/UI/list_item.dart';
import 'package:mini_projeto/blocs/product_bloc.dart';

class ShoppingList extends StatefulWidget {

  final String title;

  ShoppingList({Key key, this.title}) : super(key: key);

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {

  ProductBloc _bloc;

  _ShoppingListState() {

    this._bloc = ProductBloc();
  }

  @override
  Widget build(BuildContext context) {

    var products = this._bloc.getProducts();

    return ListView.builder(

      itemCount: products.length,

      itemBuilder: (context, index) {

        return ListItem(product: products[index], bloc: this._bloc);
      },
    );
  }

  @override
  void dispose() {

    this._bloc.dispose();
    super.dispose();
  }
}