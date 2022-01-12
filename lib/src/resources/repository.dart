import 'package:weather_app/src/resources/weather_provider.dart';

class WeatherRepository {
  final WeatherApiProvider _weatherApiProvider = WeatherApiProvider();
  Future<dynamic> fetchWeatherData(String location) =>
      _weatherApiProvider.fetchWeatherUpdate(location: location);
}

//! manage events
abstract class WeatherfetchingEvent {}

class DefaultLocationEvent extends WeatherfetchingEvent {
  final String locationData;
  DefaultLocationEvent({required this.locationData});
}

class LocationSearchEvent extends WeatherfetchingEvent {
  final String searchedLocation;
  LocationSearchEvent({required this.searchedLocation});
}

//! managed different states
abstract class WeatherFetchState {}

class WeatherInitializedState extends WeatherFetchState {}

class WeatherfetchingState extends WeatherFetchState {}

class WeatherfetchedState extends WeatherFetchState {
  final dynamic data;
  WeatherfetchedState({required this.data});
}

class WeatherErrorState extends WeatherFetchState{}

class WeatherEmptyState extends WeatherFetchState{}