import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 5),
      () => Navigator.pushNamed(context, "/home"),
    );
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,

        // ignore: prefer_const_literals_to_create_immutables
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 4,
          ),
          SizedBox(
            height: 200,
            width: 200,
            child: Image.asset("assets/images/medicscapelogo.png"),
          ),
          const SizedBox(
            height: 100,
          ),
          // const SpinKitWave(
          //   color: Color(0xFF005CA0),
          //   size: 50.0,
          // ),
          const SizedBox(
            height: 150,
          ),
          Text(
            "MAKING INDIA",
            style: GoogleFonts.getFont(
              "Lato",
              textStyle: const TextStyle(
                fontSize: 20,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF005CA0),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "A SAFER PLACE TO LIVE, WORK & PLAY",
            style: GoogleFonts.getFont(
              "Lato",
              textStyle: const TextStyle(
                decoration: TextDecoration.none,
                fontSize: 10,
                color: const Color(0xFF005CA0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
