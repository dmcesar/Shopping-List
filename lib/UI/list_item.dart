import 'package:flutter/material.dart';

import 'package:mini_projeto/UI/product_form.dart';
import 'package:mini_projeto/data/product.dart';

class ListItem extends StatefulWidget {

  final Product product;

  ListItem( {Key key, this.product} ) : super(key: key);

  @override
  _ListItemState createState()  => _ListItemState();
}

class _ListItemState extends State<ListItem> {

  @override
  Widget build(BuildContext context) {

      /* Card wrapper - for slightly round corners and a shadow */
      return Card(
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

            /* List tile - Contains text and leading or trailing icon */
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 12.0),

              /* Leading - Left arrow to tag/untag product */
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
                  widget.product.imageLocation,
                  width: 70,
                  height: 70,
                  fit: BoxFit.fill,
                ),
              ),

              /* Main text - Product name*/
              title: Text(
                widget.product.name,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  letterSpacing: 0.8,
                ),
              ),

              /* Subtitle text - Quantity and total price */
              subtitle: Text(
                "Quantity: ${widget.product.quantity}\nPrice: ${widget.product.totalPrice}€",
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
                    onPressed: () {

                    },
                  ),
                  IconButton(
                    icon: Icon(
                        Icons.add,
                        color: Colors.white
                    ),
                    tooltip: "Increment product quantity",
                    onPressed: () {

                    },
                  ),
                ],
              ),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductForm(
                      product: widget.product,
                    ),
                  ),
                );
              },
            )
        ),
    );
  }
}