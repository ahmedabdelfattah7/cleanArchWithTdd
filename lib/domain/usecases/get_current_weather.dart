import 'package:clean_arch_with_tdd_simple_weather_app/core/errors/failures.dart';
import 'package:clean_arch_with_tdd_simple_weather_app/domain/entites/weather.dart';
import 'package:clean_arch_with_tdd_simple_weather_app/domain/repostories/weather_concrete_repo.dart';
import 'package:dartz/dartz.dart';



class GetCurrentWeatherUseCse {
  final WeatherRepository weatherConcreteRepository;
  GetCurrentWeatherUseCse(this.weatherConcreteRepository);

  Future<Either<Failure, WeatherEntity>> execute(String cityName) {
    return weatherConcreteRepository.getCurrentWeather(cityName);
  }
}
