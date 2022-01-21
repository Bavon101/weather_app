import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/src/models/data_status.dart';
import 'package:weather_app/src/resources/weather_controller.dart';
import 'package:weather_app/src/widgets/images_container.dart';
import 'package:weather_app/src/widgets/weather_icon.dart';

import '../short_calls.dart';
import 'forecast_data_container.dart';

class WeatherDataCard extends StatelessWidget {
  const WeatherDataCard(
      {Key? key, required this.weatherCotroller, this.isSearch = false})
      : super(key: key);
  final WeatherCotroller weatherCotroller;
  final bool isSearch;
/// this widget accepts the controller and search status to display data accordingly
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (weatherCotroller.dataStatus == DataStatuses.loading)
          const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        if ((weatherCotroller.dataStatus == DataStatuses.done &&
                weatherCotroller.weatherData != null) ||
            (isSearch &&
                weatherCotroller.dataStatus == DataStatuses.done &&
                weatherCotroller.searchweatherData != null))
          Positioned(
            right: width(context) * .10,
            top: height(context) * .05,
            child: WeatherIcon(
              color: Colors.orangeAccent,
              height: width(context) * .20,
              width: width(context) * .20,
              iconId: isSearch
                  ? weatherCotroller.searchweatherData?.weather?.first.icon ??
                      ""
                  : weatherCotroller.weatherData?.weather?.first.icon ?? "",
            ),
          ),
          // show weather data for the current location
        if ((weatherCotroller.dataStatus == DataStatuses.done &&
                weatherCotroller.weatherData != null) ||
            (isSearch &&
                weatherCotroller.dataStatus == DataStatuses.done &&
                weatherCotroller.searchweatherData != null))
          Positioned(
            top: height(context) * .08,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Badge(
                  elevation: 0,
                  badgeColor: Colors.white.withOpacity(0),
                  badgeContent: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      (isSearch
                              ? weatherCotroller.searchweatherData!.main?.temp
                                  ?.ceil()
                                  .toString()
                              : weatherCotroller.weatherData!.main?.temp
                                  ?.ceil()
                                  .toString()) ??
                          '0',
                      style: style(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    (isSearch
                            ? (weatherCotroller
                                    .searchweatherData!.weather?.first.main ??
                                "")
                            : (weatherCotroller
                                    .weatherData!.weather?.first.main ??
                                ""))
                        .toUpperCase(),
                    style: style().copyWith(
                        fontSize: 55,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.3),
                  ),
                )
              ],
            ),
          ),
          // show the forecast data as per the current status
        if ((weatherCotroller.dataStatus == DataStatuses.done &&
                weatherCotroller.foreCastData != null) ||
            (isSearch &&
                weatherCotroller.dataStatus == DataStatuses.done &&
                weatherCotroller.searchforeCastData != null))
          Positioned(
              top: height(context) * .45,
              child: ForeCastDataContainer(
                forecast: isSearch
                    ? weatherCotroller.searchforeCastData!
                    : weatherCotroller.foreCastData!,
                temperatureData: isSearch
                    ? weatherCotroller.searchweatherData!.main!
                    : weatherCotroller.weatherData!.main!,
              )),

        // if its search mode and the location has images, we show the images
        if (isSearch &&
            (weatherCotroller.selectedPlaceData?.result?.photos?.isNotEmpty ??
                false))
          DraggableScrollableSheet(
            initialChildSize: .3,
            minChildSize: .1,
            builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: ImagesContainerView(photos: weatherCotroller.selectedPlaceData!.result!.photos!,));
          })
      ],
    );
  }

  TextStyle style() {
    return const TextStyle(
        color: Colors.white, fontSize: 95, fontWeight: FontWeight.bold);
  }
}
