import 'package:clean_arch_with_tdd_simple_weather_app/data/data_source/remote_data_source.dart';
import 'package:clean_arch_with_tdd_simple_weather_app/domain/repostories/weather_concrete_repo.dart';
import 'package:clean_arch_with_tdd_simple_weather_app/domain/usecases/get_current_weather.dart';
import 'package:clean_arch_with_tdd_simple_weather_app/presentation/bloc/waether_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;



@GenerateMocks(
  [
    WeatherRepository,
    WeatherRemoteDataSource,
    GetCurrentWeatherUseCse,
    WeatherBloc,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}