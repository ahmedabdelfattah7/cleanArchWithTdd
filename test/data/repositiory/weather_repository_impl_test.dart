import 'dart:io';

import 'package:clean_arch_with_tdd_simple_weather_app/core/errors/exception.dart';
import 'package:clean_arch_with_tdd_simple_weather_app/core/errors/failures.dart';
import 'package:clean_arch_with_tdd_simple_weather_app/data/model/weather_model.dart';
import 'package:clean_arch_with_tdd_simple_weather_app/data/repositiory/weather_repository_impl.dart';
import 'package:clean_arch_with_tdd_simple_weather_app/domain/entites/weather.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';



void main() {
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl = WeatherRepositoryImpl(
        weatherRemoteDataSource: mockWeatherRemoteDataSource);
  });

  const testWeatherModel = WeatherModel(
      cityName: 'New York',
      main: "Clouds",
      description: "overcast clouds",
      iconCode: "04d",
      tempruture: 291.93,
      preusser: 1008,
      humadity: 89);

  const testWeatherEntity = WeatherEntity(
      cityName: 'New York',
      main: "Clouds",
      description: "overcast clouds",
      iconCode: "04d",
      tempruture: 291.93,
      preusser: 1008,
      humadity: 89);

  const testCityName = 'New York';

  group('get current weather', () {
    test(
        'should return current weather when a call to data source is successful',
        () async {
      //arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
          .thenAnswer((_) async => testWeatherModel);
      //act
      final result =
          await weatherRepositoryImpl.getCurrentWeather(testCityName);
      //assert
      expect(result, equals(const Right(testWeatherEntity)));
    });
  });
  test(
    'should return server failure when a call to data source is unsuccessful',
        () async {
      // arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
          .thenThrow(ServerException());

      // act
      final result =
      await weatherRepositoryImpl.getCurrentWeather(testCityName);

      // assert
      expect(
          result, equals(const Left(ServerFailure('An error has occurred'))));
    },
  );
  test(
    'should return connection failure when the device has no internet',
        () async {
      // arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
          .thenThrow(const SocketException('Failed to connect to the network'));

      // act
      final result =
      await weatherRepositoryImpl.getCurrentWeather(testCityName);

      // assert
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    },
  );

}
