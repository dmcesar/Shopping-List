import 'package:flutter/material.dart';

import 'package:mini_projeto/UI/product_form_screen.dart';
import 'package:mini_projeto/UI/list_item.dart';

import 'package:mini_projeto/data/product.dart';
import 'package:mini_projeto/blocs/data_bloc.dart';
import 'package:mini_projeto/blocs/sensor_bloc.dart';

class ShoppingListScreen extends StatefulWidget {

  static const routeName = "/home";

  final DataBloc dataBloc;
  final SensorBloc sensorBloc;

  ShoppingListScreen({Key key, @required this.dataBloc, @required this.sensorBloc}) : super(key: key);

  @override
  _ShoppingListScreenState createState() => _ShoppingListScreenState(dataBloc, sensorBloc);
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {

  DataBloc dataBloc;
  SensorBloc sensorBloc;

  /* List containing products on Widget */
  List<Product> products;

  _ShoppingListScreenState(this.dataBloc, this.sensorBloc) {

    this.products = [];

    /* Listen on any changes for the list from DataBloc */
    this.dataBloc.output.listen((onData) {

      updateList(onData);
    });

    /* Listen on any shakes */
    this.sensorBloc.output.listen((onData) {

      print(onData);

      showAlertDialog(context);
    });
  }

  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {

        this.sensorBloc.resume();

        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed:  () {

        this.dataBloc.onClearList();

        this.sensorBloc.resume();

        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Clear list?"),
      content: Text("Pressing \"Continue\" will clear all products from the list"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  /* Re-writes products list to update UI */
  void updateList(List<Product> list) {

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
                      "Nº products : ${this.dataBloc.getTotalProducts()}",
                      style: textStyle
                  ),

                  Text(
                    "Total price: ${this.dataBloc.getCheckoutPrice()}€",
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

    this.sensorBloc.dispose();
    this.dataBloc.dispose();
    super.dispose();
  }
}