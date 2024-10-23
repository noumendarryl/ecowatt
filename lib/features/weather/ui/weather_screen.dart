import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/widgets/weather_animations.dart';
import '../../../shared/widgets/weather_info.dart';
import '../logic/weather_cubit.dart';
import '../logic/weather_state.dart';
import '../repository/weather_repository.dart';

@RoutePage()
class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController addressController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('Météo')),
      body: BlocProvider(
        create: (context) => WeatherCubit(WeatherRepository())..getWeather(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: addressController,
                decoration: InputDecoration(hintText: "Entrez une adresse"),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<WeatherCubit>().getWeatherFromAddress(addressController.text);
              },
              child: Text("Rechercher"),
            ),
            Expanded(
              child: BlocBuilder<WeatherCubit, WeatherState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => Center(child: Text('Appuyez sur le bouton pour charger la météo.')),
                    loading: () => CircularProgressIndicator(),
                    loaded: (weather)  {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          WeatherInfo(weather: weather),
                          WeatherAnimation(temperature: weather.temperature), // Pass the temperature here
                        ],
                      );
                    },
                    error: (message) => Center(child: Text(message)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}