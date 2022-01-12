import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/src/resources/repository.dart';

class WeatherBloc extends Bloc<WeatherfetchingEvent, WeatherFetchState> {
  WeatherBloc(WeatherFetchState initialState) : super(initialState);
  final WeatherRepository _weatherRepository = WeatherRepository();
  @override
  void onTransition(
      Transition<WeatherfetchingEvent, WeatherFetchState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  WeatherFetchState get initialState => WeatherInitializedState();

  Stream<WeatherFetchState> mapEventToState(WeatherfetchingEvent event) async* {
    yield WeatherfetchingState();
    List<dynamic> data = [];
    try {
      if (event is DefaultLocationEvent) {
        data = await _weatherRepository.fetchWeatherData("location");
      } else if (event is LocationSearchEvent) {
       data = await _weatherRepository.fetchWeatherData("location");
      }
      if (data.isEmpty) {
        yield WeatherEmptyState();
      } else {
        yield WeatherfetchedState(data: '');
      }
    } catch (_) {
      yield WeatherErrorState();
    }
  }
}
