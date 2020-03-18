import 'package:flutter/material.dart';

import 'package:mini_projeto/UI/shopping_list_screen.dart';
import "package:mini_projeto/UI/product_form_screen.dart";

import 'package:mini_projeto/blocs/data_bloc.dart';
import 'package:mini_projeto/blocs/form_bloc.dart';

void main() => runApp(ShoppingList());

class ShoppingList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var formBloc = FormBloc();
    var dataBloc = DataBloc(formBloc.output);

    return MaterialApp(

      title: 'iQueChumbo',

      theme: ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),

      initialRoute: ShoppingListScreen.routeName,

      routes: {

        ShoppingListScreen.routeName: (context) => ShoppingListScreen(
          formBloc: formBloc,
          dataBloc: dataBloc,
        ),

        ProductFormScreen.routeName: (context) => ProductFormScreen(
          formBloc: formBloc,
        ),
      },
    );
  }
}