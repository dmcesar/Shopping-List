/* SingletonHolder -> Stores all products */

import 'package:mini_projeto/data/product.dart';

class DataSource {

  final List<Product> _datasource;

  static DataSource _instance;

  DataSource._internal() : _datasource = Product.productNames();

  /* Returns Singleton */
  static DataSource getInstance() {

    if(_instance == null) {

      _instance = DataSource._internal();
    }

    return _instance;
  }

  /* Adds data to list */
  void insert(data) => _datasource.add(data);

  /* Returns list containing all data inserted (and dummies) */
  List<Product> getAll() => _datasource;
}