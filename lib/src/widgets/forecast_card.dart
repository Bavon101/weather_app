import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/src/models/weather_forecast_model.dart';
import 'package:weather_app/src/short_calls.dart';
import 'package:weather_app/src/widgets/weather_icon.dart';

class ForeCastCard extends StatelessWidget {
  const ForeCastCard({Key? key, required this.forecast}) : super(key: key);
  final ForeCastElement forecast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 15,
        top: 10
      ),
      child: SizedBox(
        height: height(context)*.05,
        width: width(context) - 23,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: width(context)*.15,
              child: Text(getDay(forecast.dt!))),
             WeatherIcon(
              color: Colors.white,
              height: 20,
              width: 20,
              iconId: forecast.weather?.first.icon.toString()??"01",
            ),
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
              child: Text(forecast.main?.temp?.ceil().toString()??"0",style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),),
            )
          ],
        ),
      ),
    );
  }

  String getDay(int time) {
    var date = DateTime.fromMillisecondsSinceEpoch(time*1000);
    return DateFormat('EEEE').format(date);
  }
}
