import 'dart:convert';

import 'package:clean_arch_with_tdd_simple_weather_app/data/model/weather_model.dart';
import 'package:clean_arch_with_tdd_simple_weather_app/domain/entites/weather.dart';
import 'package:flutter_test/flutter_test.dart';


import '../../helpers/json_reader.dart';

void main() {
  const testWeatherModel = WeatherModel(
      cityName: 'New York',
      main: "Clouds",
      description: "overcast clouds",
      iconCode: "04d",
      tempruture: 291.93,
      preusser: 1008,
      humadity: 89);

  test('Should be a subClass of weather entity ', () async {
//assert
    expect(testWeatherModel, isA<WeatherEntity>());
  });
  test('Should return a valid model from json', () async {
    //arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('helpers/dummy_data/dummy_weather_response.json'),
    );
    //act
    final result = WeatherModel.fromJson(jsonMap);
    //assert
    expect(result, equals(testWeatherModel));
  });

  test('should return a json map with proper data', () async {
    //act
    final result = testWeatherModel.toJson();
//assert
    final expectedJsonMap = {
      'weather': [
        {
          'main': "Clouds",
          'description': "overcast clouds",
          "icon": "04d",
        }
      ],
      "main": {"temp": 291.93, "pressure": 1008, "humidity": 89},
      "name": "New York",
    };
    expect(result, equals(expectedJsonMap));
  });
}
