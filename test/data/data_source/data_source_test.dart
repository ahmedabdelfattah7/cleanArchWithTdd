import 'package:clean_arch_with_tdd_simple_weather_app/core/constants/constants.dart';
import 'package:clean_arch_with_tdd_simple_weather_app/core/errors/exception.dart';
import 'package:clean_arch_with_tdd_simple_weather_app/data/data_source/remote_data_source.dart';
import 'package:clean_arch_with_tdd_simple_weather_app/data/model/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:http/http.dart' as http;

import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImp;
  setUp(() {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImp = WeatherRemoteDataSourceImpl( client: mockHttpClient,);
  });
  const testCityName = 'New York';
  group('get Current Weather', () {
    test('should return weather model when the response code is 200', () async {
      //arrange
      when(mockHttpClient
              .get(Uri.parse(Urls.currentWeatherByName(testCityName))))
          .thenAnswer((_) async => http.Response(
              readJson('helpers/dummy_data/dummy_weather_response.json'), 200));
      //act
      final result =
          await weatherRemoteDataSourceImp.getCurrentWeather(testCityName);
      //assert
      expect(result, isA<WeatherModel>());
    });


    test(
      'should throw a server exception when the response code is 404 or other',
          () async {
        //arrange
        when(
          mockHttpClient.get( Uri.parse(Urls.currentWeatherByName(testCityName))),
        ).thenAnswer(
                (_) async => http.Response('Not found',404)
        );

        //act
        final result = weatherRemoteDataSourceImp.getCurrentWeather(testCityName);

        //assert
        expect(result, throwsA(isA<ServerException>()));

      },
    );

  });
}
