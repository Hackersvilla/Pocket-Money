import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:pmoney/Main/home.dart';
import 'package:advance_notification/advance_notification.dart';

enum LoginScreen {
  SHOW_MOBILE_SCREEN,
  SHOW_OTP_SCREEN,
}

// ignore: camel_case_types
class Main_verify extends StatefulWidget {
  const Main_verify({Key? key}) : super(key: key);

  @override
  _Main_verifyState createState() => _Main_verifyState();
}

// ignore: camel_case_types
class _Main_verifyState extends State<Main_verify> {
  LoginScreen currentScreen = LoginScreen.SHOW_MOBILE_SCREEN;

  //variables
  String code_by_user = "";
  String text_by_user = "";
  final _controller = ScrollController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationID = "";

  //functions

  void signInWithPhoneAuthCred(AuthCredential phoneAuthCredential) async {
    try {
      final authCred = await _auth.signInWithCredential(phoneAuthCredential);
      if (authCred.user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e.message);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Some Error Occured. Try Again Later')));
    }
  }

  void getotp() async {
    if (text_by_user.isEmpty) {
      const AdvanceSnackBar(
              message: "Write Number.",
              bgColor: Color(0xff3db536),
              textColor: Colors.white,
              textAlign: TextAlign.center,
              textSize: 12,
              isFixed: false)
          .show(context);
    } else if (text_by_user.length < 10) {
      const AdvanceSnackBar(
              message: "Invalid Number.",
              bgColor: Color(0xff3db536),
              textAlign: TextAlign.center,
              textSize: 12,
              textColor: Colors.white,
              isFixed: false)
          .show(context);
    } else {
      const AdvanceSnackBar(
              message: "Verifying.",
              bgColor: Color(0xff3db536),
              textAlign: TextAlign.center,
              textSize: 12,
              textColor: Colors.white,
              isFixed: false)
          .show(context);
      await _auth.verifyPhoneNumber(
          phoneNumber: "+91${text_by_user}",
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
  }

  void verify_otp() {
    AuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: code_by_user);
    signInWithPhoneAuthCred(phoneAuthCredential);
  }

  //widget for showing mobile screen first
  showMobile(context) {
    return SafeArea(
      child: ScrollConfiguration(
        behavior: const ScrollBehavior()
          ..buildOverscrollIndicator(
              context,
              Container(),
              ScrollableDetails(
                  direction: AxisDirection.down, controller: _controller)),
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
                    onChanged: (v) {
                      text_by_user = v;
                    },
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
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
                        boxShadow: [
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
                        color: Color(0xffFF9C93),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: const Center(
                      child: Text("GET OTP",
                          style:
                              TextStyle(fontSize: 15, color: Colors.black54)),
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

  //widget for showing otp screen first
  showOtp(context) {
    return SafeArea(
      child: ScrollConfiguration(
        behavior: const ScrollBehavior()
          ..buildOverscrollIndicator(
              context,
              Container(),
              ScrollableDetails(
                  direction: AxisDirection.down, controller: _controller)),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  width: 300.w,
                  height: 300.h,
                  child: Image.asset('assest/images/second.png'),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.w),
                  child: Text(
                    "Enter OTP",
                    style: TextStyle(
                      fontSize: 25.sp,
                    ),
                  ),
                ),
                // ignore: prefer_const_constructors
                Container(
                  padding: EdgeInsets.all(30.sp),
                  child: OtpTextField(
                    numberOfFields: 6,
                    focusedBorderColor: const Color(0xffFF9C93),
                    borderColor: const Color(0xffFF9C93),
                    showFieldAsBox: true,
                    onCodeChanged: (String code) {
                      //handle validation or checks here
                    },
                    //runs when every textfield is filled
                    onSubmit: (String verificationCode) {
                      setState(() {
                        code_by_user = verificationCode;
                      });
                    }, // end onSubmit
                  ),
                ),

                //for button click
                GestureDetector(
                  onTap: verify_otp,
                  child: Container(
                    width: 170.w,
                    height: 50.h,
                    decoration: const BoxDecoration(
                        color: Color(0xffFF9C93),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: const Center(
                      child: Text("VERIFY",
                          style:
                              TextStyle(fontSize: 15, color: Colors.black54)),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: currentScreen == LoginScreen.SHOW_MOBILE_SCREEN
            ? showMobile(context)
            : showOtp(context));
  }
}
