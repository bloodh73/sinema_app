import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinKitThreeBounce(color: Colors.green, size: 50.0),
        SizedBox(height: 10),
        Text(
          'درحال بارگذاری',
          style: TextStyle(
            fontSize: 18,
            color: Colors.green,
            fontFamily: 'Lalezar',
          ),
        ),
      ],
    );
  }
}
