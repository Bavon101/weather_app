import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/src/resources/keys.dart';

class WeatherApiProvider {
  String baseUrl = "api.openweathermap.org/data/2.5/weather?";

  Future<dynamic> fetchWeatherUpdate({required String location}) async {
    final response = await http.get(Uri.parse(baseUrl + location + Keys.weatherKey));
  }

  dynamic parseResponse (http.Response response){
    final responseString = jsonDecode(response.body);

    if (response.statusCode == 200) {
      //return ApiResult.fromJson(responseString).items;
    } else {
      throw Exception('failed to weather data');
    }
  }
}
