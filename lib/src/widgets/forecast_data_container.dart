import 'package:flutter/material.dart';
import 'package:weather_app/src/models/waether_model.dart';
import 'package:weather_app/src/models/weather_forecast_model.dart';
import 'package:weather_app/src/short_calls.dart';
import 'package:weather_app/src/widgets/forecast_card.dart';
import 'package:weather_app/src/widgets/temperature_data_card.dart';

class ForeCastDataContainer extends StatelessWidget {
  const ForeCastDataContainer({Key? key, required this.forecast,required this.temperatureData})
      : super(key: key);
  final WeatherForecastDataModel forecast;
  final MainData temperatureData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CurrentemperatureCard(temperatureData: temperatureData),
        Container(
          width: width(context),
          height: 2,
          color: Colors.white,
        ), 
        ...forecast.list!.map((e) => ForeCastCard(forecast: e,)),
      ],
    );
  }
}

class CurrentemperatureCard extends StatelessWidget {
  const CurrentemperatureCard({
    Key? key,
    required this.temperatureData,
  }) : super(key: key);

  final MainData temperatureData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:( width(context) - 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TemperatureDataCard(temp: temperatureData.tempMin??0, title: "min"),
           TemperatureDataCard(
              temp: temperatureData.temp ?? 0, title: "Current"),
               TemperatureDataCard(
              temp: temperatureData.tempMax ?? 0, title: "max"),
        ],
      ),
    );
  }
}
