import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sinema_app/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size width = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topRight,
            colors: [
              Color(0xFF9C27B0), // بنفش تیره‌تر
              Color.fromARGB(255, 152, 70, 167), // بنفش روشن‌تر
            ],
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', width: width.width * 0.45),
              Text(
                'حامد کریمی زاده',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  // fontWeight: FontWeight.bold,
                  fontFamily: 'Lalezar',
                ),
              ),
              SizedBox(height: 20),
              Text(
                'WWW.BLIZZARDPING.IR',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  // fontWeight: FontWeight.bold,
                  fontFamily: 'Lalezar',
                ),
              ),
              SizedBox(height: 20),
              SpinKitThreeBounce(color: Colors.white, size: 50.0),
            ],
          ),
        ),
      ),
    );
  }
}
