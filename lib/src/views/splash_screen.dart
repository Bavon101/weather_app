import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({ Key? key }) : super(key: key);
  static const routeName = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Text("My Weather".toUpperCase(),style: const TextStyle(
          color: Colors.white,
          letterSpacing: 1.5,
          fontWeight: FontWeight.bold
        ),),
      ),
    );
  }
}