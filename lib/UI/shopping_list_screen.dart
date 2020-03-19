import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_projeto/UI/product_form_screen.dart';

import 'package:mini_projeto/data/product.dart';
import 'package:mini_projeto/blocs/form_bloc.dart';
import 'package:mini_projeto/blocs/data_bloc.dart';
import 'package:mini_projeto/UI/list_item.dart';

class ShoppingListScreen extends StatefulWidget {

  static const routeName = "/home";

  final FormBloc formBloc;
  final DataBloc dataBloc;

  ShoppingListScreen({Key key, @required this.formBloc, @required this.dataBloc}) : super(key: key);

  @override
  _ShoppingListScreenState createState() => _ShoppingListScreenState(formBloc, dataBloc);
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {

  FormBloc formBloc;
  DataBloc dataBloc;

  /* List containing products on Widget */
  List<Product> products;

  _ShoppingListScreenState(this.formBloc, this.dataBloc) {

    this.products = [];

    /* Listen on any changes for the list */
    this.dataBloc.output.listen((onData) {

      setList(onData);
    });
  }
  
  double getCheckoutPrice() {
    
    double toReturn = 0.0;
    
    this.products.forEach((p) => toReturn += p.totalPrice);

    return toReturn;
  }

  /* Re-writes products list to update UI */
  void setList(List<Product> list) {

    setState(() {

      this.products = list;
    });

    print("Updated List UI");
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      height: 1.2,
      letterSpacing: 1.8,
    );

    return Scaffold(

      appBar: AppBar(
        title: Text("Shopping List"),
      ),

      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),

      body: Column(

        children: <Widget>[

          Card(

            elevation: 8.0,
            margin:
            EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 6.0,
            ),

            child: Container(

              decoration: BoxDecoration(
                color: Color.fromRGBO(64, 75, 96, 0.9),
              ),

              height: 50.0,

              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  Text(
                      "Nº products : ${this.products.length}",
                      style: textStyle
                  ),

                  Text(
                    "Total price: ${this.getCheckoutPrice()}€",
                    style: textStyle,
                  ),
                ],
              ),
            ),
          ),

          Expanded(

            child: ListView.builder(

              itemCount: this.products.length,
              itemBuilder: (context, index) =>
                  ListItem(product: this.products[index],
                      dataBloc: this.widget.dataBloc),
            ),
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(

        onPressed: () =>
            Navigator.pushNamed(
              context,
              ProductFormScreen.routeName,
            ),

        child: Icon(
            Icons.add,
            color: Colors.white
        ),

        backgroundColor: Colors.amber,
      ),
    );
  }

  @override
  void dispose() {

    this.dataBloc.dispose();
    this.formBloc.dispose();
    super.dispose();
  }
}