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
  void addProduct(product) => this._datasource.add(product);

  /* Removes product from list */
  void removeProduct(product) => this._datasource.remove(product);

  /*
  * Loops over products
  * If p == product, change isTagged value
  * Else, maintain value
  */
  void toggleProductState(product) => this._datasource.forEach((p) => p.isTagged = (product == p) ? !p.isTagged : p.isTagged );

  /* Data "getters" */

  /* Returns all product in List form */
  List<Product> getAll() => this._datasource;
}