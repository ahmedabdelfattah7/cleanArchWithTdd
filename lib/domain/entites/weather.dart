import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final String cityName;
  final String main;
  final String description;
  final String iconCode;
  final double tempruture;
  final int preusser;
  final int humadity;

  const WeatherEntity(
      {required this.cityName,
      required this.main,
      required this.description,
      required this.iconCode,
      required this.tempruture,
      required this.preusser,
      required this.humadity});

  @override
  List<Object?> get props =>
      [cityName, main, description, iconCode, tempruture, preusser, humadity];
}
