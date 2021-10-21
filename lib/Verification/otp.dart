import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Otp extends StatefulWidget {
  Otp({Key? key}) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  child: const TextField(
                    decoration: InputDecoration(
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
                Container(
                  width: 170.w,
                  height: 50.h,
                  decoration: const BoxDecoration(
                      color: Color(0xffFF9C93),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: const Center(
                    child: Text("GET OTP",
                        style: TextStyle(fontSize: 15, color: Colors.black54)),
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
