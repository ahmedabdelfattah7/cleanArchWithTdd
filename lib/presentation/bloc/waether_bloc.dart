import 'package:clean_arch_with_tdd_simple_weather_app/domain/usecases/get_current_weather.dart';
import 'package:clean_arch_with_tdd_simple_weather_app/presentation/bloc/weather_events.dart';
import 'package:clean_arch_with_tdd_simple_weather_app/presentation/bloc/weather_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rxdart/rxdart.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCse _getCurrentWeatherUseCse;

  WeatherBloc(this._getCurrentWeatherUseCse) : super(WeatherEmpty()) {
    on<OnCityChanged>(
      (event, emit) async {
        emit(WeatherLoading());
        final result = await _getCurrentWeatherUseCse.execute(event.cityName);
        result.fold(
          (failure) {
            emit(WeatherError(failure.message));
          },
          (data) {
            emit(WeatherLoaded(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) =>
      events.debounceTime(duration).flatMap((value) => mapper(value));
}
