import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'weather.g.dart';


@JsonSerializable()
class Weather extends Equatable {

  final String cityName;
  final double temperature;

  Weather({
    @required this.cityName,
    @required this.temperature,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  @override
  // TODO: implement props
  List<Object> get props => props;



}