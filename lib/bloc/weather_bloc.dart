import 'package:bloc/bloc.dart';
import 'package:bloc_cubit_test/data/weather_repository.dart';
import 'package:meta/meta.dart';

import '../data/models/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _weatherRepository;
  WeatherBloc(this._weatherRepository) : super(const WeatherInitial()) {
    on<WeatherEvent>(getWeather); // Weather Event is GetWeather Class
  }

  //
  void getWeather(WeatherEvent event, Emitter<WeatherState> emit) async {
    if (event is GetWeather) {
      try {
        emit(const WeatherLoading());
        final weather = await _weatherRepository.fetchWeather(event.cityName);
        emit(WeatherLoaded(weather));
      } on NetworkException {
        emit(const WeatherError(
            "Could not fetch weather. Is the device online?"));
      }
    }
  }
}
