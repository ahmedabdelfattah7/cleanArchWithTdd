import 'dart:io';
import 'package:clean_arch_with_tdd_simple_weather_app/core/errors/failures.dart';
import 'package:clean_arch_with_tdd_simple_weather_app/domain/entites/weather.dart';
import 'package:clean_arch_with_tdd_simple_weather_app/domain/repostories/weather_concrete_repo.dart';
import 'package:dartz/dartz.dart';
import '../../core/errors/exception.dart';
import '../data_source/remote_data_source.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;
  WeatherRepositoryImpl({required this.weatherRemoteDataSource});

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
      String cityName) async {
    try {
      final result = await weatherRemoteDataSource.getCurrentWeather(cityName);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
