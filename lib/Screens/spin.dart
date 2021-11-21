import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:pmoney/Services/globals.dart';

class Roulette extends StatefulWidget {
  //selected.add(
  //Fortune.randomInt(0, items.length),
  //);
  @override
  State<Roulette> createState() => _RouletteState();
}

class _RouletteState extends State<Roulette> {
  var number_from_spin;

  StreamController<int> selected = StreamController<int>.broadcast();

  @override
  Widget build(BuildContext context) {
    //for alert box
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Claim $number_from_spin Points'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Collect'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    @override
    void dispose() {
      super.dispose();
      selected.close();
    }

    void button_tap() {
      setState(() {
        selected.sink.add(Fortune.randomInt(0, items.length));
      });
    }

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 50.h),
                StreamBuilder(
                    initialData: 0,
                    stream: selected.stream,
                    builder: (context, snapshot) => snapshot.data != null
                        ? SpinScore(snapshot.data)
                        : Container()),
                SizedBox(height: 50.h),
                SizedBox(
                  width: 300.w,
                  height: 300.h,
                  child: FortuneWheel(
                    physics: NoPanPhysics(),
                    animateFirst: false,
                    indicators: const <FortuneIndicator>[
                      FortuneIndicator(
                        alignment: Alignment
                            .topCenter, // <-- changing the position of the indicator
                        child: TriangleIndicator(
                          color: Color(
                              0xffFF9C93), // <-- changing the color of the indicator
                        ),
                      ),
                    ],
                    selected: selected.stream,
                    items: [
                      for (var it in items) FortuneItem(child: Text('$it')),
                    ],
                    onAnimationEnd: () async {
                      await _showMyDialog();
                    },
                  ),
                ),
                SizedBox(height: 50.h),
                GestureDetector(
                  onTap: button_tap,
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
                        style: TextStyle(fontSize: 15, color: Colors.black87),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SpinScore extends StatelessWidget {
  var count;

  SpinScore(count, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          print("$count");
        },
        child: const Text("Get the Value of count"));
  }
}
