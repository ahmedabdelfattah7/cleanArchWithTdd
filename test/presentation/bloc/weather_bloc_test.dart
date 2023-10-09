import 'package:clean_arch_with_tdd_simple_weather_app/core/errors/failures.dart';
import 'package:clean_arch_with_tdd_simple_weather_app/domain/entites/weather.dart';
import 'package:clean_arch_with_tdd_simple_weather_app/presentation/bloc/waether_bloc.dart';
import 'package:clean_arch_with_tdd_simple_weather_app/presentation/bloc/weather_events.dart';
import 'package:clean_arch_with_tdd_simple_weather_app/presentation/bloc/weather_states.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:bloc_test/bloc_test.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeatherUseCse mockGetCurrentWeatherUseCse;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeatherUseCse = MockGetCurrentWeatherUseCse();
    weatherBloc = WeatherBloc(mockGetCurrentWeatherUseCse);
  });
  test('initial sate should be empty', () async {
    expect(weatherBloc.state, WeatherEmpty());
  });
  const testWeatherEntity = WeatherEntity(
      cityName: 'New York',
      main: "Clouds",
      description: "overcast clouds",
      iconCode: "04d",
      tempruture: 291.93,
      preusser: 1008,
      humadity: 89);

  const testCityName = 'New York';
  blocTest<WeatherBloc, WeatherState>(
      'Should emit [weatherLoading, WeatherLoaded] when the data is gotten',
      build: () {
        when(mockGetCurrentWeatherUseCse.execute(testCityName)).thenAnswer(
            (realInvocation) async => const Right(testWeatherEntity));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [WeatherLoading(), const WeatherLoaded(testWeatherEntity)]);
  blocTest<WeatherBloc, WeatherState>(
      'Should emit [weatherLoading, WeatherFailure] when the data is unsuccessfully',
      build: () {
        when(mockGetCurrentWeatherUseCse.execute(testCityName)).thenAnswer(
            (realInvocation) async =>
                const Left(ServerFailure('Server Failure')));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [WeatherLoading(),  WeatherError('Server Failure')]);
}
