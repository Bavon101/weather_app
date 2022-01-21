
import 'package:flutter/material.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/src/views/search_view.dart';
import 'package:weather_app/src/widgets/weather_data_card.dart';



import '../short_calls.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: weatherCotroller, builder: (_,child)=>  Container(
        width: width(context),
        height: height(context),
        decoration:weatherCotroller.searchMode ? null: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/forest_sunny.png"),
                fit: BoxFit.cover)),
        child: weatherCotroller.searchMode ?  SearchView(places: weatherCotroller.placesList,):WeatherDataCard(weatherCotroller: weatherCotroller,)
      ),
    );
  }

  
}