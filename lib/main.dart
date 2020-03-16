import 'package:flutter/material.dart';
import 'package:mini_projeto/UI/shopping_list_screen.dart';

void main() => runApp(ShoppingList());

class ShoppingList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      title: 'iQueChumbo',

      theme: ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),

      home: ShoppingListScreen(),
    );
  }
}