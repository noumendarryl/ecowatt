import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WeatherAnimation extends StatelessWidget {
  final double temperature;

  WeatherAnimation({required this.temperature});

  @override
  Widget build(BuildContext context) {
    String animationPath; 
    //if (weatherMainCondition == null) return 'assets/sunny.json';


    // Determine which animation to show based on the temperature
    if (temperature > 30) {
      animationPath = 'assets/lottie/sunny.json'; // Sunny animation
    } else if (temperature > 20) {
      animationPath = 'assets/lottie/sunshower.json'; // Sunshower animation
    } else if (temperature > 10) {
      animationPath = 'assets/lottie/cloudy.json'; // Cloudy animation
    } else if (temperature > 0) {
      animationPath = 'assets/lottie/rainy.json'; // Rainy animation
    } else {
      animationPath = 'assets/weather/shady.json'; // Shady or snowy animation
    }

    return Center(
      child: Lottie.asset(animationPath),
    );
  }
}