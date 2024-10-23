import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/widgets/geocoding.dart';

import '../repository/weather_repository.dart';
import 'weather_state.dart';
import 'package:geolocator/geolocator.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherCubit(this.weatherRepository) : super(const WeatherState.initial());

  Future<void> getWeather() async {
    emit(const WeatherState.loading());
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      final weather = await weatherRepository.fetchWeather(position.latitude, position.longitude);
      print (weather);
      emit(WeatherState.loaded(weather));
    } catch (e) {
      emit(WeatherState.error('Erreur lors de la récupération des données météo'));
    }
  }
  Future<void> getWeatherFromAddress(String address) async {
    emit(const WeatherState.loading());
    try {
      Position position = await getCoordinatesFromAddress(address);
      final weather = await weatherRepository.fetchWeather(position.latitude, position.longitude);
      emit(WeatherState.loaded(weather));
    } catch (e) {
      emit(WeatherState.error('Erreur lors de la récupération des données météo'));
    }
  }

}