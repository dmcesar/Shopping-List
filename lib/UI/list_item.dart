import 'package:flutter/material.dart';
import 'package:mini_projeto/UI/product_form_screen.dart';
import 'dart:io';

import 'package:mini_projeto/blocs/data_bloc.dart';
import 'package:mini_projeto/data/product.dart';

class ListItem extends StatefulWidget {

  final BuildContext context;
  final Product product;
  final DataBloc dataBloc;

  ListItem( {Key key, @required this.context, @required this.product, @required this.dataBloc} ) : super(key: key);

  @override
  _ListItemState createState()  => _ListItemState();
}

class _ListItemState extends State<ListItem> {

  Color _color;

  static const tagged = Colors.amber,
      notTagged = Color.fromRGBO(64, 75, 96, 0.9);

  @override
  void initState() {

    super.initState();

    this._color = notTagged;
  }

  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () => Navigator.pop(context),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Product removed!"),
      content: Text("The selected product has been removed from the list."),
      actions: [
        okButton,
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

  void toggleItemColor() {

    this.widget.dataBloc.onToggleProductState(this.widget.product.name);

    setState(() {
      this._color = this.widget.product.isTagged ? tagged : notTagged;
    });
  }

  void incrementItemQuantity() {

    setState(() {
      this.widget.dataBloc.onIncrementProductQuantity(this.widget.product.name);
    });
  }

  void decrementItemQuantity() {

    setState(() {
      this.widget.dataBloc.onDecrementProductQuantity(this.widget.product.name);
    });
  }

  @override
  Widget build(BuildContext context) {

    /*Handles item swiping */
    return Dismissible(

      key: Key(this.widget.product.name),

      background: Container(color: Colors.red),
      secondaryBackground: Container(color: (this._color == tagged) ? notTagged : tagged),

      /* Only call onDismissed if swiped right */
      confirmDismiss: (direction) async {

        if (direction == DismissDirection.endToStart) {

          toggleItemColor();
          return false;
        }

        return true;
      },

      onDismissed: (direction) {

        this.widget.dataBloc.onRemoveProduct(this.widget.product.name);
        showAlertDialog(this.widget.context);
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
                "Quantity: ${this.widget.product.quantity}\nPrice: ${this.widget.product.totalPrice}€",
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

              onTap: () => Navigator.pushNamed(
                  context,
                  ProductFormScreen.routeName,
                  arguments: this.widget.product, /* Pass argument with routing */
              ),
            )
        ),
      ),
    );
  }
}