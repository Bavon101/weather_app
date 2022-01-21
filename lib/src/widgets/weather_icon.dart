

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/src/resources/weather_icon_model.dart';

class WeatherIcon extends StatelessWidget {
  const WeatherIcon(
      {Key? key, this.color, this.height, this.width, required this.iconId})
      : super(key: key);
  final double? width;
  final double? height;
  final Color? color;
  final String iconId;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      imagePath,
      color: color,
      semanticsLabel: 'A red up arrow',
      width: width,
      height: height,
    );
  }
  // get the icon that matches the key for the weather condition

  String get imagePath => "assets/images/${WeatherIconModel.icons[icon]}.svg";
  String get icon => iconId.substring(0, 2);
}
