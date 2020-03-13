import 'package:flutter/material.dart';
import 'package:mini_projeto/UI/list_item.dart';
import 'package:mini_projeto/blocs/product_bloc.dart';
import 'package:mini_projeto/data/product.dart';

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

    /*Returns Scrollable ListView */
    return ListView(

        /* List of Items */
        children: <Widget>[

          /* Listens to Stream events and returns ListItem objects */
          StreamBuilder(
              stream: this._bloc.output,
              builder: (BuildContext context, AsyncSnapshot snapshot) {

                /* Checks if data was received */
                if (snapshot.hasData) {

                  /* If single object was received, return ListItem */
                  if (snapshot.data.runtimeType == Product) {

                    return ListItem(product: snapshot.data as Product);
                  }
                  /* If list was received (default items), return Column containing all ListItem objects*/
                  else {
                    var products = snapshot.data as List<Product>;

                    return Column(
                      children: List.generate(
                          products.length,
                              (index) => ListItem(product: products[index])
                      ),
                    );
                  }
                }
                /* If nothing was received, return empty container */
                return Container();
              }
          ),
        ],
      );
  }

  @override
  void dispose() {

    this._bloc.dispose();
    super.dispose();
  }
}