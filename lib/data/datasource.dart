/* SingletonHolder -> Stores all products */

import 'package:mini_projeto/data/product.dart';

class DataSource {

  final List<Product> _datasource;

  static DataSource _instance;

  DataSource._internal() : _datasource = Product.init();

  /* Returns Singleton */
  static DataSource getInstance() {

    if(_instance == null) {

      _instance = DataSource._internal();
    }

    return _instance;
  }

  /* Data "setters" */

  /* Adds product to list */
  void addProduct(product) {

    this._datasource.add(product);

    print("Added $product");
  }

  /* Removes product from list */
  void removeProduct(product) {

    this._datasource.remove(product);

    print("Removed: $product");
  }

  void incrementProductQuantity(product) {

    for(var p in this._datasource) {

      if(p == product) {

        p.quantity++;

        print("Incremented quantity: $product");
      }
    }
  }

  void decrementProductQuantity(product) {

    for(var p in this._datasource) {

      if(p == product) {

        if(p.quantity > 0) {

          p.quantity--;

          print("Decremented quantity: $product");
        }
      }
    }
  }

  void toggleProductState(product) {

    for(var p in this._datasource) {

      if(p == product) {

        p.isTagged = !p.isTagged;

        print("Toggled state: $product");
      }
    }
  }

  /* Data "getters" */

  /* Returns all product in List form */
  List<Product> getAll() => this._datasource;
}