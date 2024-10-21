import 'package:flutter/material.dart';
import '../../features/weather/models/weather_model.dart';

class WeatherInfo extends StatelessWidget {
  final WeatherModel weather;

  const WeatherInfo({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Ville : ${weather.cityName}', style: TextStyle(fontSize: 24)),
        Text('Température : ${weather.temperature} °C', style: TextStyle(fontSize: 24)),
        Text('Conditions : ${weather.description}', style: TextStyle(fontSize: 24)),
      ],
    );
  }
}