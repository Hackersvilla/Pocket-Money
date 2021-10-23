import 'dart:async';
import 'package:lottie/lottie.dart';
import 'Verification/main_verify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: () => MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: GoogleFonts.lato().fontFamily,
          primarySwatch: Colors.blue,
        ),
        home: const MyHome(),
      ),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 6),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Main_verify())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 300.w,
              height: 300.h,
              child: Lottie.asset('assest/anim/animation.json'),
            ),
          ),
          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'Pocket Money',
                textStyle: const TextStyle(fontSize: 30),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
