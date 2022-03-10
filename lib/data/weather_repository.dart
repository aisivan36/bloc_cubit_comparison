import 'dart:math';

import 'package:bloc_cubit_test/data/models/weather.dart';

abstract class WeatherRepository {
  /// throws [NetworkException]
  Future<Weather> fetchWeather(String cityName);
}

class FakeWeatherRepository implements WeatherRepository {
  @override
  Future<Weather> fetchWeather(String cityName) {
    // Simulate network delay
    return Future.delayed(
      const Duration(seconds: 1),
      () {
        final random = Random();
        // simulate some network exception
        if (random.nextBool()) {
          throw NetworkException();
        }

        // fetched weather
        return Weather(
          cityName: cityName,
          // Temperature between 20 and 25.99
          temperatureCelcius: 20 + random.nextInt(15) + random.nextDouble(),
        );
      },
    );
  }
}

class NetworkException implements Exception {}
