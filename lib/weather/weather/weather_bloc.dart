import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_hydraded/Model/weather.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends HydratedBloc<WeatherEvent, WeatherState> {

  WeatherBloc() : super(WeatherInitial()) {
    hydrate();
  }



  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    // TODO: Add your event logic

    if (event is GetWeather) {
      yield WeatherLoading();
      final weather  = await _fetchWeatherFromFakeApi(event.cityName);
      yield WeatherLoaded(weather);

    }
  }

  Future<Weather> _fetchWeatherFromFakeApi(String cityName) {
    // Simulate network delay
    return Future.delayed(
      Duration(seconds: 1),
          () {
        return Weather(
          cityName: cityName,
          // Temperature between 20 and 35.99
          temperature: 20 + Random().nextInt(15) + Random().nextDouble(),
        );
      },
    );
  }



  @override
  WeatherState fromJson(Map<String, dynamic> json) {

    try{

      final weather = Weather.fromJson(json);
      return WeatherLoaded(weather);

    }
    catch(_){
      return null;

    }
  }

  @override
  Map<String, dynamic> toJson(WeatherState state) {
    // TODO: implement toJson
    return (state is WeatherLoaded) ? state.weather.toJson() : null;

    if (state is WeatherLoaded) {
      return state.weather.toJson();
    }
    return null;

  }

}
