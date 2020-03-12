import 'package:flutter/material.dart';
import 'package:mini_projeto/UI/product_screen.dart';
import 'package:mini_projeto/data/product.dart';

class ListItem extends StatelessWidget {

  final Product _product;

  ListItem(this._product);

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
                horizontal: 20.0, vertical: 10.0),

            /* Leading - Left arrow to tag/untag product */
            leading: Icon(
                Icons.keyboard_arrow_left, color: Colors.white,
                size: 30.0),

            /* Main text - Product name*/
            title: Text(
              this._product.name,
              style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),

            /* Subtitle text - Quantity and total price */
            subtitle: Text(
                "Quantity: #${this._product.quantity}  |  Price: ${this._product.totalPrice}€",
                style: TextStyle(color: Colors.white)
            ),

            /* Trailing - Border separator and product image */
            trailing: Container(
              padding: EdgeInsets.only(left: 15.0),
              decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(
                      width: 1.0,
                      color: Colors.white24,
                    )
                ),
              ),
              child: Image.asset(
                this._product.imageLocation,
                width: 70,
                height: 70,
                fit: BoxFit.fill,
              ),
            ),

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductFormScreen(
                    product: _product,
                  ),
                ),
              );
            },
          )
      ),
    );
  }
}