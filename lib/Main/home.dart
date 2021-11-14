import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pmoney/Screens/spin.dart';

class Home extends StatefulWidget {
  const Home({key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void spin_tap() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Roulette()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //for scores
              score(),
              //container for spin and win
              spin_win(),
              const SizedBox(
                height: 20,
              ),
              scratch_card(),
              const SizedBox(
                height: 20,
              ),
              reddem()
            ],
          ),
        ),
      ),
    );
  }

  //widgets
  score() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            child: Text("Balance",
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(
                  child: Image(
                      width: 20,
                      height: 20,
                      image: AssetImage('assest/images/rupee.png')),
                ),
                SizedBox(
                  child: Text("100",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  spin_win() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 50.h, 120.w, 0),
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Container(
            width: 250.w,
            height: 110.h,
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xff20a854),
                    offset: Offset(
                      5.0,
                      5.0,
                    ),
                    blurRadius: 20.0,
                    spreadRadius: 1.0,
                  )
                ],
                color: Colors.green[400],
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: Container(
              margin: EdgeInsets.fromLTRB(25.w, 35.h, 0.w, 0),
              child: const Text(
                "Spin & Win",
                style: TextStyle(color: Colors.black87, fontSize: 25),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20.h,
              horizontal: 20.h,
            ),
            child: GestureDetector(
              onTap: spin_tap,
              child: Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(80)),
                child: const Icon(
                  Icons.keyboard_arrow_right_outlined,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  scratch_card() {
    return Padding(
      padding: EdgeInsets.fromLTRB(120.w, 50.h, 0.w, 0),
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Container(
            width: 250.w,
            height: 110.h,
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xff3289a8),
                    offset: Offset(
                      5.0,
                      5.0,
                    ),
                    blurRadius: 20.0,
                    spreadRadius: 1.0,
                  )
                ],
                color: Colors.blue[300],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
            child: Container(
              margin: EdgeInsets.fromLTRB(100.w, 35.h, 0.w, 0),
              child: const Text(
                "Scatch Cards",
                style: TextStyle(color: Colors.black87, fontSize: 25),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20.h,
              horizontal: 20.h,
            ),
            child: Container(
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(80)),
              child: const Icon(
                Icons.keyboard_arrow_left_outlined,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  reddem() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 50.h, 120.w, 0),
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Container(
            width: 250.w,
            height: 110.h,
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffe87164),
                    offset: Offset(
                      5.0,
                      5.0,
                    ),
                    blurRadius: 20.0,
                    spreadRadius: 1.0,
                  )
                ],
                color: Colors.deepOrange[300],
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: Container(
              margin: EdgeInsets.fromLTRB(45.w, 35.h, 0.w, 0),
              child: const Text(
                "Reddem",
                style: TextStyle(color: Colors.black87, fontSize: 25),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20.h,
              horizontal: 20.h,
            ),
            child: Container(
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(80)),
              child: const Icon(
                Icons.keyboard_arrow_right_outlined,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
