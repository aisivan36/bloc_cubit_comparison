import 'package:bloc/bloc.dart';
import 'package:bloc_cubit_test/data/models/weather.dart';
import 'package:bloc_cubit_test/data/weather_repository.dart';
import 'package:meta/meta.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this._weatherRepository) : super(const WeatherInitial());

  final WeatherRepository _weatherRepository;

  Future<void> getWeather(String cityName) async {
    try {
      emit(const WeatherLoading());
      final weather = await _weatherRepository.fetchWeather(cityName);
      emit(WeatherLoaded(weather));
    } on NetworkException {
      emit(
          const WeatherError("Could not fetch weather. Is the device online?"));
    }
  }
}
