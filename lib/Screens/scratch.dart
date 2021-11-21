import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scratcher/scratcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScratchCards extends StatefulWidget {
  ScratchCards({Key? key}) : super(key: key);

  @override
  _ScratchCardsState createState() => _ScratchCardsState();
}

class _ScratchCardsState extends State<ScratchCards> {
  int random_number = Random().nextInt(50);
  final scratchKey = GlobalKey<ScratcherState>();

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Claim $random_number Points'),
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

  get_a_scratch_card() {
    return Container(
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
          color: Color(0xff3289a8),
          offset: Offset(
            5.0,
            5.0,
          ),
          blurRadius: 20.0,
          spreadRadius: 1.0,
        )
      ], color: Colors.blueGrey[900], borderRadius: BorderRadius.circular(30)),
      child: Scratcher(
        key: scratchKey,
        brushSize: 30,
        threshold: 50,
        onScratchEnd: () {},
        color: (Colors.blue[300])!,
        onChange: (value) => {},
        child: SizedBox(
          height: 300,
          width: 300,
          child: Center(
            child: Text('$random_number',
                style: const TextStyle(color: Colors.white, fontSize: 30)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100.h,
                ),
                get_a_scratch_card(),
                SizedBox(
                  height: 100.h,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      scratchKey.currentState
                          ?.reset(duration: const Duration(milliseconds: 2000));
                      random_number = Random().nextInt(50);
                    });
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
                        "New Card",
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
