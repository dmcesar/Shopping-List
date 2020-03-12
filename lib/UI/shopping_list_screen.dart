import 'package:flutter/material.dart';
import 'package:mini_projeto/UI/list_item.dart';
import 'package:mini_projeto/UI/product_screen.dart';
import 'package:mini_projeto/blocs/product_bloc.dart';
import 'package:mini_projeto/data/product.dart';

class ShoppingListPage extends StatefulWidget {

  final String title;

  ShoppingListPage({Key key, this.title}) : super(key: key);

  @override
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {

  ProductBloc _bloc;

  _ShoppingListPageState() {

    this._bloc = ProductBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(widget.title),
      ),

      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),

      body: Center(

        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {

            /* Enables vertical scrolling */
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                ),

                /* Products displayed vertically */
                child: Column(

                  /* List of Items */
                  children: <Widget>[

                    /* Stream listener and item builder */
                    StreamBuilder(
                      stream: this._bloc.output,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {

                        /* Checks if data was received */
                        if (snapshot.hasData) {

                          /* If single object was received, return ListItem */
                          if (snapshot.data.runtimeType == Product) {
                            return ListItem(snapshot.data as Product);

                          }
                          /* If list was received, return Column containing all ListItem objects*/
                          else {
                            var products = snapshot.data as List<Product>;

                            return Column(
                              children: List.generate(
                                  products.length,
                                      (index) => ListItem(products[index])
                              ),
                            );
                          }
                        }
                        /* If nothing was received, return empty container */
                        return Container();
                      }
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),

      /* 'Add Product' form FAB */
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductFormScreen(),
              ),
            ),
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.orange,
      ),
    );
  }

  @override
  void dispose() {

    this._bloc.dispose();
    super.dispose();
  }
}