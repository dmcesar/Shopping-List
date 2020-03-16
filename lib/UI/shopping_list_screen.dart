import 'package:flutter/material.dart';

import 'package:mini_projeto/data/product.dart';
import 'package:mini_projeto/blocs/form_bloc.dart';
import 'package:mini_projeto/blocs/list_bloc.dart';
import 'package:mini_projeto/UI/list_item.dart';
import 'package:mini_projeto/UI/product_form_screen.dart';

class ShoppingListScreen extends StatefulWidget {

  ShoppingListScreen({Key key}) : super(key: key);

  @override
  _ShoppingListScreenState createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {

  /* List containing products on Widget */
  List<Product> products;

  /* Business logic layer */
  ListBloc _listBloc;
  FormBloc _formBloc;

  _ShoppingListScreenState() {

    this._formBloc = FormBloc();

    this._listBloc = ListBloc(this._formBloc.output);

    this.products = [];

    /* Listen on any changes for the list */
    this._listBloc.output.listen((onData) {

      print(onData.runtimeType);

      setList(onData);
    });
  }

  /* Re-writes products list to update UI */
  void setList(List<Product> list) {

    setState(() {

      this.products = list;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Shopping List"),
      ),

      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),

      body: ListView.builder(

          itemCount: this.products.length,
          itemBuilder: (context, index) =>
              ListItem(product: this.products[index], bloc: this._listBloc)
      ),

      floatingActionButton: FloatingActionButton(

        onPressed: () =>
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductForm(bloc: this._formBloc),
              ),
            ),
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.orange,
      ),
    );
  }

  @override
  void dispose() {

    this._listBloc.dispose();
    this._formBloc.dispose();
    super.dispose();
  }
}