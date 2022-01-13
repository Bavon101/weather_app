import 'package:flutter/cupertino.dart';
import 'package:weather_app/src/resources/weather_provider.dart';

class WeatherCotroller with ChangeNotifier {
  final WeatherApiProvider _weatherApiProvider = WeatherApiProvider();
  double? _latitude;
  double? _longitude;
  Future<void> setLatLon(double lat, double lon) async {
    _latitude = lat;
    _longitude = lon;
    notifyListeners();
  }
}
