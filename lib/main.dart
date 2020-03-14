import 'package:flutter/material.dart';

import 'UI/product_form.dart';
import 'UI/shopping_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      title: 'iQueChumbo',
      theme: ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),

      home: Scaffold(

        appBar: AppBar(
          title: Text("Shopping List"),
        ),

        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),

        body: ShoppingList(),

        /*
        * Button to add new Product to List
        * TODO: MAKE MOVABLE
        */
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductForm(),
                ),
              ),
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.orange,
        ),
      ),
    );
  }
}