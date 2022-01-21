import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class TemperatureDataCard extends StatelessWidget {
  const TemperatureDataCard({Key? key,required this.temp,required this.title}) : super(key: key);
  final double temp;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Badge(
          padding: const EdgeInsets.only(left: 10),
          elevation: 0,
            badgeColor: Colors.white.withOpacity(0),
            badgeContent: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white)),
            ),
          child: Text(temp.ceil().toString(),style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white,letterSpacing: 1.2,fontSize: 24),)),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(title),
        )
      ],
    );
  }
}
