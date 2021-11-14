import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmoney/Services/globals.dart' as globals;

class RouletteScore extends StatelessWidget {
  final int selected;

  final Map<int, String> labels = {
    1: '\$ 1000 ',
    2: '\$ 400 ',
    3: '\$ 800 ',
    4: '\$ 7000 ',
    5: '\$ 5000 ',
    6: '\$ 300 ',
    7: '\$ 2000 ',
    8: '\$ 100 ',
  };

  RouletteScore(this.selected);

  @override
  Widget build(BuildContext context) {
    globals.score = labels[selected];
    return Text(labels[selected],
        style: const TextStyle(
            fontStyle: FontStyle.italic, fontSize: 24.0, color: Colors.white));
  }
}
