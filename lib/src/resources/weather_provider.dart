import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:weather_app/src/models/place_data_model.dart';
import 'package:weather_app/src/models/place_model.dart';
import 'package:weather_app/src/models/waether_model.dart';
import 'package:weather_app/src/models/weather_forecast_model.dart';
import 'package:weather_app/src/resources/keys.dart';

class WeatherApiProvider {
  final String _baseUrl = "https://api.openweathermap.org/data/2.5/weather?";
  final String _forecastBaseUrl =
      "https://api.openweathermap.org/data/2.5/forecast?";

  //!fetch weather data
  Future<WeatherDataModel?> fetchWeatherUpdate(
      {required String location}) async {
    final response = await http.get(Uri.parse(
        _baseUrl + location + '&units=metric&appid=' + Keys.weatherKey));
    if (response.statusCode == 200) {
      return WeatherDataModel.fromRawJson(response.body);
    } else {
      throw Exception('failed to fetch weather data');
    }
  }

  //! fetch weather forecast

  Future<WeatherForecastDataModel?> fetchForecast(
      {required String location}) async {
    final response = await http.get(Uri.parse(_forecastBaseUrl +
        location +
        '&units=metric&appid=' +
        Keys.weatherKey));
    if (response.statusCode == 200) {
      return WeatherForecastDataModel.fromRawJson(response.body);
    } else {
      throw Exception('failed to fetch weather data');
    }
  }
  // use the gmap api to get location query, the API key i'll remove when pushing the code
  Future<Place?> getPlaces(
      {required String query,
      required String location,
      String radius = '10000'}) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?key=${Keys.gmapKey}&input=${Uri.encodeQueryComponent(query)}&location=$location&radius=$radius";
    final response = await http.get(Uri.parse(url));
    return Place.fromRawJson(response.body);
  }

  // funtion to decode locatio via location id, it gets alllocation data

  Future<PlaceData?> decodeGLocation({required String placeId}) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/details/json?key=${Keys.gmapKey}&placeid=" +
            Uri.encodeQueryComponent(placeId);
    final response = await http.get(Uri.parse(url));
    return PlaceData.fromRawJson(response.body);
  }
}
