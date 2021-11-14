import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pmoney/Services/spin_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pmoney/Services/globals.dart' as globals;

//_wheelNotifier.sink.add(_generateRandomVelocity())

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 400, 0),
                      child: const Icon(Icons.arrow_back_ios_new,
                          color: Colors.white)),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.h),
                  child: StreamBuilder(
                    stream: _dividerController.stream,
                    builder: (context, snapshot) => snapshot.hasData
                        ? RouletteScore(snapshot.data)
                        : Container(),
                  ),
                ),
                const SizedBox(height: 70),
                SpinningWheel(
                  Image.asset('assest/images/wheel.png'),
                  width: 310,
                  height: 310,
                  initialSpinAngle: _generateRandomAngle(),
                  spinResistance: 0.6,
                  canInteractWhileSpinning: false,
                  dividers: 8,
                  onUpdate: _dividerController.add,
                  onEnd: () {
                    Fluttertoast.showToast(msg: globals.score);
                  },
                  secondaryImage: Image.asset('assest/images/pointer.png'),
                  secondaryImageHeight: 110,
                  secondaryImageWidth: 110,
                  shouldStartOrStop: _wheelNotifier.stream,
                ),
                const SizedBox(height: 100),
                GestureDetector(
                  onTap: () {
                    _wheelNotifier.sink.add(_generateRandomVelocity());
                  },
                  child: Container(
                    width: 200.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xffFF9C93),
                            offset: Offset(
                              5.0,
                              5.0,
                            ),
                            blurRadius: 20.0,
                            spreadRadius: 1.0,
                          )
                        ],
                        color: const Color(0xffFF9C93),
                        borderRadius: BorderRadius.circular(30)),
                    child: const Center(
                      child: Text(
                        "Spin",
                        style: TextStyle(fontSize: 20, color: Colors.black54),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _generateRandomVelocity() => (Random().nextDouble() * 6000) + 2000;

  double _generateRandomAngle() => Random().nextDouble() * pi * 2;
}
