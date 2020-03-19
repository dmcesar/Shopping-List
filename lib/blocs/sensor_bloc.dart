import 'dart:async';

import 'package:sensors/sensors.dart';

class SensorBloc {

  StreamSubscription _streamSubscription;
  Stream<AccelerometerEvent> stream;

  StreamController<String> _controller;

  SensorBloc() {

    /* Creates widget-bloc stream */
    this._controller = StreamController<String>();

    /* Gets stream from sensors.dart */
    this.stream = accelerometerEvents;

    this._streamSubscription = this.stream.listen((AccelerometerEvent event) {

      if(event.x >= 5) {

        pause();

        signalShake();
      }
    });
  }

  Stream get output => _controller.stream;

  void signalShake() {

    /* Signal widget to show pop-up */
    this._controller.add("Shaked!");
  }

  void pause() {

    /* Stop handling events */
    this._streamSubscription.pause();
  }

  void resume() {

    /* Clear any other events received */
    this.stream.drain();

    this._streamSubscription.resume();
  }

  void dispose() {

    /* Close widget-bloc stream (stops signaling widget) */
    this._controller.close();

    /* Cancel stream subscription (stops listening for events) */
    this._streamSubscription.cancel();
  }
}