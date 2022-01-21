import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/src/short_calls.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({ Key? key }) : super(key: key);
  static const routeName = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffd5a0),
      body: Center(
        child: SvgPicture.asset(
      "assets/images/weather.svg",
      color: Colors.green,
      semanticsLabel: 'A red up arrow',
      width: width(context)*.33,
      height: height(context)*.20,
    ),
      ),
    );
  }
}