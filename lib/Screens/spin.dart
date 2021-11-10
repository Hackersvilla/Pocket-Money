import 'package:flutter/material.dart';

class SpinScreen extends StatefulWidget {
  SpinScreen({Key? key}) : super(key: key);

  @override
  _SpinScreenState createState() => _SpinScreenState();
}

class _SpinScreenState extends State<SpinScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: const Center(
        child: Text(
          "Spin and Win Screen",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
