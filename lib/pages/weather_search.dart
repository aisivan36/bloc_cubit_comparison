// TODO uncomment the one whether bloc or cubit to avoid conflict State
import 'package:bloc_cubit_test/bloc/weather_bloc.dart';
// import 'package:bloc_cubit_test/cubit/weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/weather.dart';

class WeatherSearch extends StatefulWidget {
  const WeatherSearch({Key? key}) : super(key: key);

  @override
  State<WeatherSearch> createState() => _WeatherSearchState();
}

class _WeatherSearchState extends State<WeatherSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Weather App'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        //// TODO this is a Cubit
        // child: BlocConsumer<WeatherCubit, WeatherState>(

        ///// TODO Bloc version
        child: BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is WeatherError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is WeatherInitial) {
              return const BuildInitialInput();
            } else if (state is WeatherLoading) {
              return const BuildLoading();
            } else if (state is WeatherLoaded) {
              return BuildColumnWithData(weather: state.weather);
            } else {
              // (State is WeatherError)
              return const BuildInitialInput();
            }
          },
        ),
      ),
    );
  }
}

class BuildInitialInput extends StatelessWidget {
  const BuildInitialInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CityInputField(),
    );
  }
}

class BuildLoading extends StatelessWidget {
  const BuildLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class BuildColumnWithData extends StatelessWidget {
  const BuildColumnWithData({Key? key, required this.weather})
      : super(key: key);

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          weather.cityName,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          // Display the temperature with 1 decimal place
          "${weather.temperatureCelcius.toStringAsFixed(1)} °C",
          style: const TextStyle(fontSize: 80),
        ),
        const CityInputField(),
      ],
    );
  }
}

class CityInputField extends StatelessWidget {
  const CityInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (val) => submitCityName(context, val),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Enter a City",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }

  void submitCityName(BuildContext context, String cityName) {
    //// TODO This is a Cubit
    // final weatherCubit = context.read<WeatherCubit>();
    // weatherCubit.getWeather(cityName);

    ///// TODO Bloc version
    final weatherCubit = context.read<WeatherBloc>();
    // add the event
    weatherCubit.add(GetWeather(cityName));
  }
}
