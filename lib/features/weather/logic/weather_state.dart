import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/weather_model.dart';


part 'weather_state.freezed.dart';

@freezed
class WeatherState with _$WeatherState {
  const factory WeatherState.initial() = WeatherInitial;
  const factory WeatherState.loading() = WeatherLoading;
  const factory WeatherState.loaded(WeatherModel weather) = WeatherLoaded;
  const factory WeatherState.error(String message) = WeatherError;
}