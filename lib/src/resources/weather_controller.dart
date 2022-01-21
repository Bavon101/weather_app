import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:weather_app/src/models/data_status.dart';
import 'package:weather_app/src/models/place_data_model.dart';
import 'package:weather_app/src/models/place_model.dart';
import 'package:weather_app/src/models/waether_model.dart';
import 'package:weather_app/src/models/weather_forecast_model.dart';
import 'package:weather_app/src/resources/weather_provider.dart';

class WeatherCotroller with ChangeNotifier {
  // declare all in app use variables
  final WeatherApiProvider _weatherApiProvider = WeatherApiProvider();
  WeatherDataModel? _weatherData;
  WeatherForecastDataModel? _foreCastData;
  WeatherDataModel? _searchweatherData;
  WeatherForecastDataModel? _searchforeCastData;
  WeatherForecastDataModel? _foreCastDataFiltered;
  PlaceData? _selectedPlaceData;
  bool _searchMode = false;
  String _status = "_loading";
  double? _latitude;
  double? _longitude;
  List<PlacePrediction> _placesList = [];
  // location setting container, the location is set and the data is automaticaly retrived
  Future<void> setLatLon(double lat, double lon) async {
    _latitude = lat;
    _longitude = lon;
    notifyListeners();
    if (currentLatitude != 0 && currentLongitude != 0) {
      if (weatherData == null) {
        await _getWeatherData();
        _updateDataStatus(DataStatuses.done);
        await _fetchForecast();
        _updateDataStatus(DataStatuses.done);
        notifyListeners();
      }
    }
  }
// get variaus data
  String get dataStatus => _status;
  WeatherDataModel? get weatherData => _weatherData;
  WeatherForecastDataModel? get foreCastData => _foreCastData;
  WeatherForecastDataModel? get foreCastDataFiltered => _foreCastDataFiltered;
  WeatherDataModel? get searchweatherData => _searchweatherData;
  WeatherForecastDataModel? get searchforeCastData => _searchforeCastData;

  double get currentLatitude => _latitude ?? 0;
  double get currentLongitude => _longitude ?? 0;
  String get _locationParam => "lat=$currentLatitude&lon=$currentLongitude";
  bool get searchMode => _searchMode;
  String get _geoLocation =>
      currentLatitude.toString() + currentLongitude.toString();
  List<PlacePrediction> get placesList => _placesList;
  PlaceData? get selectedPlaceData => _selectedPlaceData;

// fetch waether data, provide bool value for issearch mode do know which data to be transfered
  Future<void> _getWeatherData({bool isSearch = false}) async {
    
    try {
      if (isSearch) {
        _searchweatherData = await _weatherApiProvider.fetchWeatherUpdate(
            location:
                "lat=${selectedPlaceData!.result!.geometry!.location!.lat}&lon=${selectedPlaceData!.result!.geometry!.location!.lng}");
      } else {
        _updateDataStatus(DataStatuses.loadingWeatherData);
        _weatherData = await _weatherApiProvider.fetchWeatherUpdate(
            location: _locationParam);
      }
    } catch (e) {
      _updateDataStatus(DataStatuses.dataError);
      log(e.toString());
    }
  }

// fetch forecast same logic as data
  Future<void> _fetchForecast({bool isSearch = false}) async {
    
    try {
      if (isSearch) {
        _searchforeCastData = await _weatherApiProvider.fetchForecast(
            location:
                "lat=${selectedPlaceData!.result!.geometry!.location!.lat}&lon=${selectedPlaceData!.result!.geometry!.location!.lng}");
      } else {
        _updateDataStatus(DataStatuses.loadFocastData);
        _foreCastData =
            await _weatherApiProvider.fetchForecast(location: _locationParam);
      }
      _filterForecasts(isSearch: isSearch);
    } catch (e) {
      _updateDataStatus(DataStatuses.dataError);
       log(e.toString());
    }
  }

  // update the data status, what is happening in data stages

  Future<void> _updateDataStatus(String status) async {
    _status = status;
    notifyListeners();
  }
// filter forecast via date in order to provide only a day's data for each day
  Future<void> _filterForecasts({bool isSearch = false}) async {
    if (isSearch) {
      searchforeCastData!.list!.unique((e) => e.dtTxt!.day);
    } else {
      foreCastData!.list!.unique((e) => e.dtTxt!.day);
    }
    notifyListeners();
  }

  // update search status, this controlls how the normal and search ui interact

  Future<void> updateSearchStatus(bool status) async {
    _searchMode = status;
    notifyListeners();
  }

// get the location that the user is querying
  Future<void> getSearchedLocation(String query) async {
    Place? _places = await _weatherApiProvider.getPlaces(
        query: query, location: _geoLocation);
    if (_places != null) {
      _placesList = _places.predictions ?? [];
      notifyListeners();
    }
  }
// clear the places data list
  Future<void> clearPlaces() async {
    _placesList.clear();
    notifyListeners();
  }
// get geo data via the provided location id
  Future<void> decodeSearchedQuery(String placeId) async {
    _selectedPlaceData =
        await _weatherApiProvider.decodeGLocation(placeId: placeId);
    if (selectedPlaceData != null) {
      await _getWeatherSearch();
    }
    notifyListeners();
  }
// get data as per isSearch=true
  Future<void> _getWeatherSearch() async {
    await _getWeatherData(isSearch: true);
    await _fetchForecast(isSearch: true);
    _updateDataStatus(DataStatuses.done);
    notifyListeners();
  }
}
//Extensio override to smoothly filter data
extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = <dynamic>{};
    var list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}
