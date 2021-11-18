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
  StreamController<int> selected = StreamController<int>();

  @override
  Widget build(BuildContext context) {
    final items = <int>[
      1000,
      100,
      500,
      300,
      400,
      200,
    ];

    @override
    void dispose() {
      super.dispose();
      selected.close();
    }

    void button_tap() {
      setState(() {
        selected.add(Fortune.randomInt(0, items.length));
      });
      ;
    }

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 150.h),
                SizedBox(
                  width: 300.w,
                  height: 300.h,
                  child: FortuneWheel(
                    animateFirst: false,
                    selected: selected.stream,
                    items: [
                      for (var it in items) FortuneItem(child: Text('$it')),
                    ],
                  ),
                ),
                SizedBox(height: 50.h),
                GestureDetector(
                  onTap: button_tap,
                  child: Container(
                      width: 300.w,
                      height: 70.h,
                      decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Center(
                        child:
                            Text("Spin", style: TextStyle(color: Colors.white)),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
