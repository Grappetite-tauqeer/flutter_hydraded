part of 'weather_bloc.dart';

@immutable
abstract class WeatherState extends Equatable{

  WeatherState([List props = const []]);

}

class WeatherInitial extends WeatherState {

  WeatherInitial([List props = const []]);

  @override
  // TODO: implement props
  List<Object> get props => props;

}

class WeatherLoading extends WeatherState {

  WeatherLoading([List props = const []]);

  @override
  // TODO: implement props
  List<Object> get props => props;
}

class WeatherLoaded extends WeatherState {
  final Weather weather;

  WeatherLoaded(this.weather) : super([weather]);
  List<Object> get props => props;


}