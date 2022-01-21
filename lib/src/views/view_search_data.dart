import 'package:flutter/material.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/src/short_calls.dart';
import 'package:weather_app/src/widgets/weather_data_card.dart';

class SearchedDataView extends StatelessWidget {
  const SearchedDataView({ Key? key }) : super(key: key);
  static const routeName = '/search_data';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(weatherCotroller.selectedPlaceData?.result?.formattedAddress??""),
      ),
      body: AnimatedBuilder(animation: weatherCotroller, builder: (context, child) => Container(
       decoration : const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/forest_sunny.png"),
                fit: BoxFit.cover)),
        height: height(context),
        width: width(context),
        child: WeatherDataCard(weatherCotroller: weatherCotroller,isSearch: true,)),),
    );
  }
}