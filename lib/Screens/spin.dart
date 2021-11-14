import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';

class Roulette extends StatelessWidget {
  final StreamController _dividerController = StreamController<int>();

  final _wheelNotifier = StreamController<double>();

  dispose() {
    _dividerController.close();
    _wheelNotifier.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinningWheel(
              Image.asset('assest/images/wheel.png'),
              width: 310,
              height: 310,
              initialSpinAngle: _generateRandomAngle(),
              spinResistance: 0.6,
              canInteractWhileSpinning: false,
              dividers: 8,
              onUpdate: _dividerController.add,
              onEnd: _dividerController.add,
              secondaryImage: Image.asset('assest/images/pointer.png'),
              secondaryImageHeight: 110,
              secondaryImageWidth: 110,
              shouldStartOrStop: _wheelNotifier.stream,
            ),
            const SizedBox(height: 30),
            StreamBuilder(
              stream: _dividerController.stream,
              builder: (context, snapshot) =>
                  snapshot.hasData ? RouletteScore(snapshot.data) : Container(),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              child: const Text("Start"),
              onPressed: () =>
                  _wheelNotifier.sink.add(_generateRandomVelocity()),
            )
          ],
        ),
      ),
    );
  }

  double _generateRandomVelocity() => (Random().nextDouble() * 6000) + 2000;

  double _generateRandomAngle() => Random().nextDouble() * pi * 2;
}

class RouletteScore extends StatelessWidget {
  var selected;

  final Map<int, String> labels = {
    1: '5',
    2: '15',
    3: '25',
    4: '40',
    5: '50',
    6: '30',
    7: '20',
    8: '10',
  };

  RouletteScore(this.selected);

  @override
  Widget build(BuildContext context) {
    return Text('${labels[selected]}',
        style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 24.0));
  }
}
