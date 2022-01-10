import 'package:flutter/material.dart';
import 'package:weather_app/src/short_calls.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  static const  routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width(context),
        height: height(context),
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/forest_sunny.png"),fit: BoxFit.cover)
        ),
      ),
    );
  }
}
