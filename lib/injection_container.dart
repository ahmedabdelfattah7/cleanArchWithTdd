import 'package:clean_arch_with_tdd_simple_weather_app/data/data_source/remote_data_source.dart';
import 'package:clean_arch_with_tdd_simple_weather_app/data/repositiory/weather_repository_impl.dart';
import 'package:clean_arch_with_tdd_simple_weather_app/domain/repostories/weather_concrete_repo.dart';
import 'package:clean_arch_with_tdd_simple_weather_app/domain/usecases/get_current_weather.dart';
import 'package:clean_arch_with_tdd_simple_weather_app/presentation/bloc/waether_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void setupLocator() {
  //bloc
  locator.registerFactory(() => WeatherBloc(locator()));
  //useCase
  locator.registerLazySingleton(() => GetCurrentWeatherUseCse(locator()));
  //repository
  locator.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(weatherRemoteDataSource: locator()));
  //dataSource
  locator.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(
            client: locator(),
          ));
  //http
  locator.registerLazySingleton(() => http.Client());
}
