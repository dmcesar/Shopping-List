/* SingletonHolder -> Stores all products */

import 'package:mini_projeto/data/product.dart';

class DataSource {

  final Map<String, Product> _datasource;

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

  /* Clears data */
  void clear() => this._datasource.clear();

  /* Adds product to data */
  void addProduct(Product product) {

    this._datasource.putIfAbsent(product.name, () => product);

    print("Added $product");
  }

  /* Replaces existing product with updated data */
  void modifyProduct(Product product) {

    this._datasource[product.name] = product;

    print("Modified $product");
  }

  /* Removes product from list */
  void removeProduct(String key) {

    this._datasource.remove(key);

    print("Removed: $key");
  }

  /* Data getters */

  /* Returns all entries in form List<value> */
  List<Product> getAll() {

    List<Product> products = List();

    this._datasource.forEach((k, v) => products.add(v));

    return products;
  }

  /* Returns product with existing key or null */
  Product getProduct(String key) {

    if(this._datasource.containsKey(key)) {

      return this._datasource[key];
    }

    return null;
  }
}