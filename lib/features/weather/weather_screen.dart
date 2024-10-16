// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:lottie/lottie.dart';
// import 'package:weather/weather.dart';
//
// import '../../shared/widgets/widget_layout.dart';
//
// class WeatherScreen extends StatefulWidget {
//   const WeatherScreen({super.key});
//
//   @override
//   State<WeatherScreen> createState() => _WeatherScreenState();
// }
//
// class _WeatherScreenState extends State<WeatherScreen> {
//   late Size mediaSize;
//   final WeatherFactory _wf = WeatherFactory("8f0efc4544b14d8a717df547170ab1a6");
//   List<Weather>? _weathers;
//   Weather? _weather;
//
//   @override
//   void initState() {
//     super.initState();
//     _wf.currentWeatherByCityName("Douala").then((w) {
//       setState(() {
//         _weather = w;
//       });
//     });
//     _wf.fiveDayForecastByCityName("Douala").then((w) {
//       setState(() {
//         _weathers = w;
//       });
//     });
//     /*_getWeatherForecast();*/
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     mediaSize = MediaQuery.of(context).size;
//     if (_weathers == null) {
//       return Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/nuage2.png'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: const Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(),
//           ],
//         ),
//       );
//     }
//     return WidgetLayout(
//       showAppBar: true,
//       showBottomNavBar: true,
//       isLeading: true,
//       leadingWidth: 50.0,
//       centered: true,
//       title: Text(
//         "Weather",
//         style: TextStyle(
//             color: Theme.of(context).colorScheme.inversePrimary,
//             fontFamily: Theme.of(context).textTheme.bodyLarge!.fontFamily),
//       ),
//       centerTitle: true,
//       child: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 50),
//                 _buildBottom(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBottom() {
//     return SizedBox(
//       width: mediaSize.width,
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(32.0),
//             child: _buildForm(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildForm() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildSingleData(),
//         const SizedBox(height: 30),
//         _buildWeatherForecast(),
//       ],
//     );
//   }
//
//   Widget _buildSingleData() {
//     String location = _weather?.areaName ?? "";
//     DateTime? now = _weather?.date;
//
//     if (_weather == null || now == null) {
//       return Center(
//         child: Text(
//           'No Data available',
//           style: TextStyle(
//               color: Theme.of(context).colorScheme.inversePrimary,
//               fontSize: 24),
//         ),
//       );
//     }
//
//     String getWeatherAnimation(String? weatherMainCondition) {
//       if (weatherMainCondition == null) return 'assets/sunny.json';
//
//       switch (weatherMainCondition.toLowerCase()) {
//         case 'coord':
//           return 'assets/weather/shady.json';
//         case 'clouds':
//           return 'assets/weather/cloudy.json';
//         case 'rain':
//           return 'assets/weather/rainy.json';
//         case 'wind':
//           return 'assets/weather/sunshower.json';
//         case 'main':
//           return 'assets/weather/clear.json';
//         default:
//           return 'assets/weather/sunny.json';
//       }
//     }
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Center(
//               child: Text(
//                 location,
//                 style: TextStyle(
//                   color: Theme.of(context).colorScheme.inversePrimary,
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                   fontFamily:
//                       Theme.of(context).textTheme.headlineLarge!.fontFamily,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.max,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     DateFormat("EEEE").format(now),
//                     style: TextStyle(
//                         color: Theme.of(context).colorScheme.inversePrimary,
//                         fontSize: 20,
//                         fontWeight: FontWeight.w400,
//                         fontFamily: Theme.of(context)
//                             .textTheme
//                             .headlineLarge!
//                             .fontFamily),
//                   ),
//                   const SizedBox(
//                     width: 5,
//                   ),
//                   Text(
//                     DateFormat("d/M/y").format(now),
//                     style: TextStyle(
//                       color: Theme.of(context).colorScheme.inversePrimary,
//                       fontSize: 20,
//                       fontWeight: FontWeight.w400,
//                       fontFamily:
//                           Theme.of(context).textTheme.headlineLarge!.fontFamily,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 15.0,
//             ),
//             Lottie.asset(getWeatherAnimation(_weather?.weatherMain)),
//             const SizedBox(height: 20),
//             Center(
//               child: Text(
//                 "${_weather?.temperature?.celsius?.toStringAsFixed(0)}°C",
//                 style: TextStyle(
//                   color: Theme.of(context).colorScheme.primary,
//                   fontSize: 96.0,
//                   fontWeight: FontWeight.bold,
//                   fontFamily:
//                       Theme.of(context).textTheme.headlineLarge!.fontFamily,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildWeatherForecast() {
//     if (_weathers == null) {
//       return Center(
//         child: Text(
//           'Weather Forecast Unavailable',
//           style: TextStyle(
//               color: Theme.of(context).colorScheme.inversePrimary,
//               fontSize: 24),
//         ),
//       );
//     }
//
//     return Column(
//       children: [
//         Text(
//           'Next 3 days Weather Forecast',
//           style: TextStyle(
//               color: Theme.of(context).colorScheme.inversePrimary,
//               fontSize: 24),
//           textAlign: TextAlign.center,
//         ),
//         const SizedBox(height: 20.0,),
//         Column(
//           children: List.generate(7, (index) {
//             final weather = _weathers![index];
//             final dateTime = weather.date;
//
//             if (dateTime == null) {
//               return const SizedBox
//                   .shrink(); // Ignore les entrées avec des dates nulles
//             }
//
//             final dayOfWeek = DateFormat('EEEE').format(dateTime);
//             final temperature =
//                 weather.temperature?.celsius?.toStringAsFixed(0);
//
//             return Wrap(
//               runSpacing: 5.0,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       dayOfWeek,
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       "$temperature°C",
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 if (index < 6)
//                   Divider(
//                       color: Theme.of(context)
//                           .colorScheme
//                           .inversePrimary
//                           .withOpacity(0.4),
//                       thickness: 0.5),
//               ],
//             );
//           }),
//         ),
//       ],
//     );
//   }
// }
