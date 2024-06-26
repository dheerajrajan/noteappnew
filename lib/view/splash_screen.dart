// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:noteappnew/view/noteHome/note_home.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => NoteHome(),
            ));
      },
    );
    return Scaffold(
      body: Center(
        child: Lottie.asset("assets/animation/Animation - 1719335562101.json",
            height: 300, width: 300),
      ),
    );
  }
}
