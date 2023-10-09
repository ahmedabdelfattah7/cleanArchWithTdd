import 'package:clean_arch_with_tdd_simple_weather_app/core/errors/failures.dart';
import 'package:clean_arch_with_tdd_simple_weather_app/domain/entites/weather.dart';
import 'package:dartz/dartz.dart';


abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName);
}

