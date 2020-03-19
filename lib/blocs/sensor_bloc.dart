import 'dart:async';

import 'package:sensors/sensors.dart';

class SensorBloc {

  StreamSubscription _streamSubscription;

  StreamController _controller;

  SensorBloc() {

    /* Creates widget-bloc stream */
    this._controller = StreamController();

    this._streamSubscription = accelerometerEvents.listen((AccelerometerEvent event) {

      if(event.x >= 5) {

        pause();

        signalShake();
      }
    });
  }

  Stream get output => _controller.stream;

  void pause() {

    /* Stop handling events */
    this._streamSubscription.pause();
  }

  void signalShake() {

    /* Signal widget to show pop-up */
    this._controller.add("Shaked!");
  }

  void resume() {

    /* Clear any other events received */
    accelerometerEvents.drain();

    this._streamSubscription.resume();
  }

  void dispose() {

    /* Close widget-bloc stream (stops signaling widget) */
    this._controller.close();

    /* Cancel stream subscription (stops listening for events) */
    this._streamSubscription.cancel();
  }
}