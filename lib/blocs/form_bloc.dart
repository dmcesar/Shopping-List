import 'dart:async';

class FormBloc {

  StreamController _controller;

  FormBloc() {

    /* Create stream controller */
    this._controller = StreamController();
  }

  /* I/O getters */
  Sink get input => _controller.sink;

  Stream get output => _controller.stream;

  void onSubmit(product) => this.input.add(product);

  void dispose() => _controller.close();
}