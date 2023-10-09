import 'dart:io';
import 'package:bloc_test/bloc_test.dart';
import 'package:clean_arch_with_tdd_simple_weather_app/domain/entites/weather.dart';
import 'package:clean_arch_with_tdd_simple_weather_app/presentation/bloc/waether_bloc.dart';
import 'package:clean_arch_with_tdd_simple_weather_app/presentation/bloc/weather_events.dart';
import 'package:clean_arch_with_tdd_simple_weather_app/presentation/bloc/weather_states.dart';
import 'package:clean_arch_with_tdd_simple_weather_app/presentation/pages/weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';



class MockWeatherBloc extends MockBloc<WeatherEvent,WeatherState> implements WeatherBloc {  }

void main() {

  late MockWeatherBloc mockWeatherBloc;

  setUp((){
    mockWeatherBloc = MockWeatherBloc();
    HttpOverrides.global = null;
  });


  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WeatherBloc>(
      create: (context) => mockWeatherBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const testWeatherEntity = WeatherEntity(
      cityName: 'New York',
      main: "Clouds",
      description: "overcast clouds",
      iconCode: "04d",
      tempruture: 291.93,
      preusser: 1008,
      humadity: 89);

  const testCityName = 'New York';


  testWidgets(
    'text field should trigger state to change from empty to loading',
        (widgetTester) async {
      //arrange
      when(()=> mockWeatherBloc.state).thenReturn(WeatherEmpty());

      //act
      await widgetTester.pumpWidget(_makeTestableWidget(const WeatherPage()));
      var textField = find.byType(TextField);
      expect(textField, findsOneWidget);
      await widgetTester.enterText(textField, 'New York');
      await widgetTester.pump();
      expect(find.text('New York'),findsOneWidget);
    },
  );


  testWidgets(
    'should show progress indicator when state is loading',
        (widgetTester) async {
      //arrange
      when(()=> mockWeatherBloc.state).thenReturn(WeatherLoading());

      //act
      await widgetTester.pumpWidget(_makeTestableWidget(const WeatherPage()));

      //assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );


  testWidgets(
    'should show widget contain weather data when state is weather loaded',
        (widgetTester) async {
      //arrange
      when(()=> mockWeatherBloc.state).thenReturn(const WeatherLoaded(testWeatherEntity));

      //act
      await widgetTester.pumpWidget(_makeTestableWidget(const WeatherPage()));

      //assert
      expect(find.byKey(const Key('weather_data')), findsOneWidget);
    },
  );




}