import 'package:flutter/material.dart';
import '../../features/weather/models/weather_model.dart';

class WeatherInfo extends StatelessWidget {
  final WeatherModel weather;

  const WeatherInfo({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Ville : ${weather.cityName}', style: const TextStyle(fontSize: 24)),
        Text('Température : ${weather.temperature} °C', style: const TextStyle(fontSize: 24)),
        Text('Conditions : ${weather.description}', style: const TextStyle(fontSize: 24)),
      ],
    );
  }
}