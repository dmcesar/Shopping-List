import 'dart:async';

import 'package:mini_projeto/data/datasource.dart';

class ListBloc {

  /* Data access layer */
  DataSource _data;

  StreamController _controller;

  ListBloc(Stream stream) {

    /* Get Singleton */
    this._data = DataSource.getInstance();

    /* Create stream controller */
    this._controller = StreamController();

    /* Init stream with data */
    _getProducts();

    /* Listens to form bloc's stream on any new product to be added */
    stream.listen((data) => this.onAddProduct(data));
  }

  Stream get output => _controller.stream;

  /* Main operations */

  /* Fetch products list from repository and adds it to sink */
  void _getProducts() => this._controller.add(this._data.getAll());

  void onAddProduct(product) {

    /* Add data to repository */
    this._data.addProduct(product);

    _getProducts();
  }

  void onRemoveProduct(product) {

    /* Remove data from repository */
    this._data.removeProduct(product);

    /* Re-writes list to sink */
    _getProducts();
  }

  void onIncrementProductQuantity(product) {

    /* Change data attribute in repository */
    this._data.incrementProductQuantity(product);

    /* Re-writes list to sink */
    _getProducts();
  }

  void onDecrementProductQuantity(product) {

    /* Change data attribute in repository */
    this._data.decrementProductQuantity(product);

    /* Re-writes list to sink */
    _getProducts();
  }

  void onToggleProductState(product) {

    /* Change data attribute in repository */
    this._data.toggleProductState(product);

    /* Re-writes list to sink */
    _getProducts();
  }

  void dispose() => _controller.close();
}