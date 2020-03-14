import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mini_projeto/UI/product_form.dart';
import 'package:mini_projeto/blocs/product_bloc.dart';
import 'package:mini_projeto/data/product.dart';

class ListItem extends StatefulWidget {

  final Product product;
  final ProductBloc bloc;

  ListItem( {Key key, this.product, this.bloc} ) : super(key: key);

  @override
  _ListItemState createState()  => _ListItemState(this.bloc);
}

class _ListItemState extends State<ListItem> {

  var _color;
  final ProductBloc _bloc;

  static const tagged = Colors.red,
      notTagged = Color.fromRGBO(64, 75, 96, 0.9);

  _ListItemState(this._bloc) {

    this._color = notTagged;
  }

  void toggleItemColor() {

    this._bloc.onToggleProductState(this.widget.product);

    setState(() {
      this._color = this.widget.product.isTagged ? tagged : notTagged;
    });
  }

  void incrementItemQuantity() {

    setState(() {
      this.widget.product.quantity++;
    });
  }

  void decrementItemQuantity() {

    setState(() {
      this.widget.product.quantity--;
    });
  }

  @override
  Widget build(BuildContext context) {

    /*Handles item swiping */
    return Dismissible(

      key: Key(this.widget.product.name),

      background: Container(color: Colors.red),
      secondaryBackground: Container(color: Colors.green),

      /* Only call onDismissed if swiped right */
      confirmDismiss: (direction) async {

        if (direction == DismissDirection.endToStart) {

          toggleItemColor();
          return false;
        }

        return true;
      },

      onDismissed: (direction) {

      },

      /* Card wrapper - for slightly round corners and a shadow */
      child: Card(
        elevation: 8.0,
        margin:
        EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 6.0,
        ),

        child: Container(
            decoration: BoxDecoration(
              color: this._color,
            ),

            /* List tile - Contains text and leading or trailing icon */
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 12.0),

              /* Leading - Left arrow to tag/un-tag product */
              leading: Container(
                padding: EdgeInsets.only(right: 20.0),
                decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(
                        width: 1.0,
                        color: Colors.white24,
                      )
                  ),
                ),
                child: Image.asset(
                  this.widget.product.imageLocation,
                  width: 70,
                  height: 70,
                  fit: BoxFit.fill,
                ),
              ),

              /* Main text - Product name*/
              title: Text(
                this.widget.product.name,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  letterSpacing: 0.8,
                ),
              ),

              /* Subtitle text - Quantity and total price */
              subtitle: Text(
                "Quantity: ${this.widget.product.quantity}\nPrice: ${this.widget
                    .product.totalPrice}€",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  letterSpacing: 0.8,
                ),
              ),

              trailing: Row(

                mainAxisSize: MainAxisSize.min,

                children: <Widget>[

                  IconButton(
                    icon: Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                    tooltip: "Decrement product quantity",
                    onPressed: () => decrementItemQuantity(),
                  ),

                  IconButton(
                    icon: Icon(
                        Icons.add,
                        color: Colors.white
                    ),
                    tooltip: "Increment product quantity",
                    onPressed: () => incrementItemQuantity(),
                  ),
                ],
              ),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductForm(
                          product: this.widget.product,
                        ),
                  ),
                );
              },
            )
        ),
      ),
    );
  }
}