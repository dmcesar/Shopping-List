import 'package:flutter/material.dart';
import 'dart:io';

import 'package:mini_projeto/UI/product_form_screen.dart';
import 'package:mini_projeto/blocs/form_bloc.dart';
import 'package:mini_projeto/blocs/list_bloc.dart';
import 'package:mini_projeto/data/product.dart';

class ListItem extends StatefulWidget {

  final Product product;
  final ListBloc listBloc;
  final FormBloc formBloc;

  ListItem( {Key key, this.product, this.listBloc, this.formBloc} ) : super(key: key);

  @override
  _ListItemState createState()  => _ListItemState();
}

class _ListItemState extends State<ListItem> {

  var _color;

  static const tagged = Colors.amber,
      notTagged = Color.fromRGBO(64, 75, 96, 0.9);

  _ListItemState() {

    this._color = notTagged;
  }

  void toggleItemColor() {

    this.widget.listBloc.onToggleProductState(this.widget.product);

    setState(() {
      this._color = this.widget.product.isTagged ? tagged : notTagged;
    });
  }

  void incrementItemQuantity() {

    setState(() {
      this.widget.listBloc.onIncrementProductQuantity(this.widget.product);
    });
  }

  void decrementItemQuantity() {

    setState(() {
      this.widget.listBloc.onDecrementProductQuantity(this.widget.product);
    });
  }

  @override
  Widget build(BuildContext context) {

    /*Handles item swiping */
    return Dismissible(

      key: Key(this.widget.product.name),

      background: Container(color: Colors.red),
      secondaryBackground: Container(color: (_color == tagged) ? notTagged : tagged),

      /* Only call onDismissed if swiped right */
      confirmDismiss: (direction) async {

        if (direction == DismissDirection.endToStart) {

          toggleItemColor();
          return false;
        }

        return true;
      },

      onDismissed: (direction) {

        this.widget.listBloc.onRemoveProduct(this.widget.product);
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
                  horizontal: 20.0, vertical: 12.0
              ),

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
                child: Container(
                  width: 75.0,
                  height: 75.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, /* Makes image circular */
                    image: DecorationImage(
                      image: (this.widget.product.assetImage)
                      ? AssetImage(this.widget.product.imageLocation)
                      : FileImage(File(this.widget.product.imageLocation)),
                      fit: BoxFit.fill, /* Fill area with image (no clipping) */
                    ),
                  ),
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
                          bloc: this.widget.formBloc,
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