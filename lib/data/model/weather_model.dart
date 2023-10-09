

import 'package:clean_arch_with_tdd_simple_weather_app/domain/entites/weather.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel(
      {required super.cityName,
      required super.main,
      required super.description,
      required super.iconCode,
      required super.tempruture,
      required super.preusser,
      required super.humadity});
  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        cityName: json['name'],
        main: json['weather'][0]['main'],
        description: json['weather'][0]['description'],
        iconCode: json['weather'][0]['icon'],
        tempruture: json['main']['temp'],
        preusser: json['main']['pressure'],
        humadity: json['main']['humidity'],
      );

  Map<String, dynamic> toJson() => {
    'weather': [
      {
        'main': main,
        'description': description,
        'icon': iconCode,
      },
    ],
    'main': {
      'temp': tempruture,
      'pressure': preusser,
      'humidity': humadity,
    },
    'name': cityName,
  };
  WeatherEntity toEntity() => WeatherEntity(
    cityName: cityName,
    main: main,
    description: description,
    iconCode: iconCode,
    tempruture: tempruture,
    preusser: preusser,
    humadity: humadity,
  );
}

