import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherRepository {
  final String apiKey = '787ae82d20123ee66c52b89e0cdec328';

  Future<WeatherModel> fetchWeather(double latitude, double longitude) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return WeatherModel(
        cityName: data['name'],
        temperature: data['main']['temp'].toDouble(),
        description: data['weather'][0]['description'],
        icon: data['weather'][0]['icon'],
      );
    } else {
      throw Exception('Échec de chargement des données météo');
    }
  }
}
