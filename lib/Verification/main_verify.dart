import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum LoginScreen { SHOW_MOBILE_SCREEN, SHOW_OTP_SCREEN }

// ignore: camel_case_types
class Main_verify extends StatefulWidget {
  const Main_verify({Key? key}) : super(key: key);

  @override
  _Main_verifyState createState() => _Main_verifyState();
}

// ignore: camel_case_types
class _Main_verifyState extends State<Main_verify> {
  //show mobile screen first
  LoginScreen currentScreen = LoginScreen.SHOW_MOBILE_SCREEN;

  //variables
  final _textcontroller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationID = "";

  //functions

  void getotp() async {
    await _auth.verifyPhoneNumber(
        phoneNumber: "+91${_textcontroller.text}",
        verificationCompleted: (phoneAuthCredential) async {},
        verificationFailed: (verificationFailed) {
          print(verificationFailed);
        },
        codeSent: (verificationID, resendingToken) async {
          setState(() {
            currentScreen = LoginScreen.SHOW_OTP_SCREEN;
            this.verificationID = verificationID;
          });
        },
        codeAutoRetrievalTimeout: (verificationID) async {});
  }

  //widget for showing mobile screen first
  showMobile(context) {
    SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                width: 300.w,
                height: 300.h,
                child: Image.asset('assest/images/first.png'),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.w),
                child: Text(
                  "OTP Verification",
                  style: TextStyle(
                    fontSize: 25.sp,
                  ),
                ),
              ),
              // ignore: prefer_const_constructors
              Container(
                padding: EdgeInsets.all(30.sp),
                child: TextField(
                  controller: _textcontroller,
                  decoration: const InputDecoration(
                    prefixText: "+91 ",
                    label: Text("Enter Paytm Number"),
                    labelStyle: TextStyle(color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
              ),

              //for button click
              GestureDetector(
                onTap: getotp,
                child: Container(
                  width: 170.w,
                  height: 50.h,
                  decoration: const BoxDecoration(
                      color: Color(0xffFF9C93),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: const Center(
                    child: Text("GET OTP",
                        style: TextStyle(fontSize: 15, color: Colors.black54)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //widget for showing otp screen first
  showOtp(context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentScreen == LoginScreen.SHOW_MOBILE_SCREEN
          ? showMobile(context)
          : showOtp(context),
    );
  }
}
