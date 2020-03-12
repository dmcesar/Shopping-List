import 'package:flutter/material.dart';
import 'UI/shopping_list_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iQueChumbo',
      theme: ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
      home: ShoppingListPage(title: 'Shopping List'),
    );
  }
}