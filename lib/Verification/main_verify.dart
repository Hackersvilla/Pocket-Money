import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:email_validator/email_validator.dart';
import 'package:email_auth/email_auth.dart';
import 'package:pmoney/Main/home.dart';
import 'package:pmoney/Services/shared_pref_ser.dart';
import 'package:concentric_transition/concentric_transition.dart';

enum Screen { SHOW_EMAIL_SCREEN, SHOW_OTP_SCREEN }

class Main_verify extends StatefulWidget {
  const Main_verify({key}) : super(key: key);

  @override
  _Main_verifyState createState() => _Main_verifyState();
}

class _Main_verifyState extends State<Main_verify> {
  Screen current_screen = Screen.SHOW_EMAIL_SCREEN;
  var email_by_user = '';
  final TextEditingController _emailController = TextEditingController();
  var code_by_user = '';

  TextEditingController otpController = TextEditingController();

  late EmailAuth emailAuth;
  SharedPref pref = SharedPref();

  @override
  void initState() {
    super.initState();
    emailAuth = EmailAuth(sessionName: "Pocket Money");
  }

  void send_otp() async {
    bool res = await emailAuth.sendOtp(
        recipientMail: _emailController.text, otpLength: 5);
    if (res) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Otp Sent"),
        ),
      );
      setState(() {
        current_screen = Screen.SHOW_OTP_SCREEN;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Otp Not Given. Try Again"),
        ),
      );
    }
  }

  void send_email_otp() {
    if (email_by_user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter Email First'),
        ),
      );
    } else if (EmailValidator.validate(email_by_user)) {
      send_otp();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid Email'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[900],
        body: current_screen == Screen.SHOW_EMAIL_SCREEN
            ? showEmailScreen(context)
            : showOTPScreen(context));
  }

  //widget Creation for email page
  showEmailScreen(context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            //make for the image
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              height: 300.h,
              width: 300.w,
              child: const Image(
                image: AssetImage('assest/images/first.png'),
              ),
            ),
            //text
            const SizedBox(
              child: Text(
                "Email Verification",
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            //make for textfield
            Container(
              padding: EdgeInsets.all(30.sp),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                controller: _emailController,
                onChanged: (v) {
                  email_by_user = v;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email_rounded, color: Colors.white),
                  label: Text("Enter Email"),
                  labelStyle: TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.white)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
            //button to get otp
            GestureDetector(
              onTap: send_email_otp,
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
                    "Get Otp",
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //widget creation for otp page page
  showOTPScreen(context) {
    return SafeArea(
      child: SingleChildScrollView(
          child: Column(
        children: [
          //make for the image
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    current_screen = Screen.SHOW_EMAIL_SCREEN;
                  });
                },
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10.h),
                    width: 30.w,
                    height: 30.h,
                    child: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.white)),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                height: 300.h,
                width: 300.w,
                child: const Image(
                  image: AssetImage('assest/images/second.png'),
                ),
              ),
            ],
          ),
          //text
          const SizedBox(
            child: Text(
              "Enter Otp",
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
          SizedBox(
            height: 50.h,
          ),
          OtpTextField(
            textStyle: const TextStyle(color: Colors.white),
            numberOfFields: 6,
            borderColor: Colors.white,
            showFieldAsBox: true,
            enabledBorderColor: Colors.white,
            focusedBorderColor: Colors.white,
            onCodeChanged: (String code) {
              setState(() {
                code_by_user = code;
              });
            },
            onSubmit: (String verificationCode) async {
              print(code_by_user);
              print(verificationCode);
              bool res = emailAuth.validateOtp(
                recipientMail: email_by_user,
                userOtp: verificationCode,
              );
              if (res) {
                pref.save_data(email_by_user);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Verified"),
                  ),
                );
                Navigator.push(
                  context,
                  ConcentricPageRoute(
                    builder: (ctx) {
                      return Home();
                    },
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Wrong Otp"),
                  ),
                );
              }
            }, // end onSubmit
          ),
        ],
      )),
    );
  }
}
