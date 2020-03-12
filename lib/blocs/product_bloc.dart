/* Data repository */

import 'dart:async';

import 'package:mini_projeto/data/datasource.dart';

class ProductBloc {

  DataSource _data;

  /* Middle-man stream */
  StreamController _controller;

  ProductBloc() {

    this._data = DataSource.getInstance();

    this._controller = StreamController();

    /* Add default products list to sink */
    this.input.add(_getProducts());
  }

  Sink get input => _controller.sink;

  Stream get output => _controller.stream;

  List _getProducts() {

    return this._data.getAll();
  }

  void add(product) => this._data.insert(product);

  void dispose() => _controller.close();
}