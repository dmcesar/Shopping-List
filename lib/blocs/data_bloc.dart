import 'dart:async';

import 'package:mini_projeto/data/datasource.dart';
import 'package:mini_projeto/data/product.dart';

class DataBloc {

  /* Data access layer */
  DataSource _data;

  StreamController _controller;

  DataBloc(Stream stream) {

    /* Get Singleton */
    this._data = DataSource.getInstance();

    /* Create stream controller */
    this._controller = StreamController();

    /* Init stream with data */
    _getProducts();

    /* Listens to form bloc's stream on any new product to be added */
    stream.listen((data) => this.onAddOrModify(data));
  }

  Stream get output => _controller.stream;

  /* Main operations */

  double getCheckoutPrice() {

    double toReturn = 0.0;

    this._data.getAll().forEach((p) => toReturn += p.totalPrice);

    return toReturn;
  }

  int getTotalProducts() {

    int toReturn = 0;

    this._data.getAll().forEach((p) => toReturn += p.quantity);

    return toReturn;
  }

  /* Data operations */

  /* Fetch products list from repository and adds it to sink */
  void _getProducts() => this._controller.add(this._data.getAll());

  /* Clears list */
  void onClearList() {

    this._data.clear();

    _getProducts();
  }

  /* Modifies product if already exists in memory or adds it to data */
  void onAddOrModify(Product product) {

    if (this._data.getProduct(product.name) != null) {

      this._data.modifyProduct(product);

    } else this._data.addProduct(product);

    _getProducts();
  }

  void onRemoveProduct(String productName) {

    /* Remove data from repository */
    this._data.removeProduct(productName);

    /* Re-writes list to sink */
    _getProducts();
  }

  void onIncrementProductQuantity(String productName) {

    /* Fetches product from repository */
    Product toModify = this._data.getProduct(productName);

    /* Increments quantity */
    toModify.quantity++;

    /* Modifies data */
    this._data.modifyProduct(toModify);

    /* Re-writes list to sink */
    _getProducts();
  }

  void onDecrementProductQuantity(String productName) {

    /* Fetches product from repository */
    Product toModify = this._data.getProduct(productName);

    if (toModify.quantity > 0) {

      /* Decrements quantity */
      toModify.quantity--;

      /* Modifies data */
      this._data.modifyProduct(toModify);

      /* Re-writes list to sink */
      _getProducts();
    }
  }

  void onToggleProductState(String productName) {

    /* Fetches product from repository */
    Product toModify = this._data.getProduct(productName);

    /* Toggles status */
    toModify.isTagged = !toModify.isTagged;

    /* Modifies data */
    this._data.modifyProduct(toModify);

    /* Re-writes list to sink */
    _getProducts();
  }

  void dispose() => this._controller.close();
}