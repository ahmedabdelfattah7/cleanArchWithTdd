import 'package:clean_arch_with_tdd_simple_weather_app/domain/entites/weather.dart';
import 'package:clean_arch_with_tdd_simple_weather_app/domain/usecases/get_current_weather.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetCurrentWeatherUseCse getCurrentWeatherUseCse;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCse = GetCurrentWeatherUseCse(mockWeatherRepository);
  });
  const testWeatherDetail = WeatherEntity(
      cityName: 'New York',
      main: 'Clouds',
      description: 'Few Clouds',
      iconCode: '02d',
      tempruture: 302.28,
      preusser: 1009,
      humadity: 70);
  const tCityName = 'New York';
  test('Should get current weather detail from the repository', () async {
    //arrange
    when(mockWeatherRepository.getCurrentWeather(tCityName))
        .thenAnswer((_) async => const Right(testWeatherDetail));
    //act
    final result = await getCurrentWeatherUseCse.execute(tCityName);
    //assert
    expect(result, const Right(testWeatherDetail));
  });
}
