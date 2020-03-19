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

  /* Fetch products list from repository and adds it to sink */
  void _getProducts() => this._controller.add(this._data.getAll());

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

  void onClearList() {

    this._data.clear();

    _getProducts();
  }

  /* Modifies product if already exists in memory or adds it to data */
  void onAddOrModify(Product product) {

    if(this._data.getProduct(product.name) != null) {

      this._data.modifyProduct(product);

    } else this._data.addProduct(product);

    _getProducts();
  }

  void onRemoveProduct(Product product) {

    /* Remove data from repository */
    this._data.removeProduct(product);

    /* Re-writes list to sink */
    _getProducts();
  }

  void onIncrementProductQuantity(Product product) {

    /* Fetches product from repository */
    Product toModify = this._data.getProduct(product.name);

    /* Increments quantity */
    toModify.quantity++;

    /* Modifies data */
    this._data.modifyProduct(toModify);

    /* Re-writes list to sink */
    _getProducts();
  }

  void onDecrementProductQuantity(Product product) {

    /* Fetches product from repository */
    Product toModify = this._data.getProduct(product.name);

    if(toModify.quantity > 0) {

      /* Decrements quantity */
      toModify.quantity--;

      /* Modifies data */
      this._data.modifyProduct(toModify);

      /* Re-writes list to sink */
      _getProducts();
    }
  }

  void onToggleProductState(Product product) {

    /* Fetches product from repository */
    Product toModify = this._data.getProduct(product.name);

    /* Toggles status */
    toModify.isTagged = !toModify.isTagged;

    /* Modifies data */
    this._data.modifyProduct(toModify);

    /* Re-writes list to sink */
    _getProducts();
  }

  void dispose() => _controller.close();
}