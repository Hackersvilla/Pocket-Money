import 'package:flutter/material.dart';

class Otp extends StatefulWidget {
  Otp({Key? key}) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: avoid_unnecessary_containers
      body: Center(
        child: Container(child: const Text("Otp")),
      ),
    );
  }
}
