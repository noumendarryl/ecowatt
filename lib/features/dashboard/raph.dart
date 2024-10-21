// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart'; // Utilisé pour les graphiques, tu peux le personnaliser.
//
// class DashboardPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildAppBar(context),
//       body: Column(
//         children: [
//           _buildHeaderSection(),
//           _buildGraphSection(),
//           _buildStatsSection(),
//         ],
//       ),
//       bottomNavigationBar: CustomBottomNavigationBar(
//         currentIndex: 0, // Exemple, changer selon la page actuelle.
//         onTap: (index) {
//           // Logique de navigation (déjà dans BaseLayout)
//         },
//       ),
//       floatingActionButton: buildFloatingActionButton(),
//     );
//   }
//
//   AppBar _buildAppBar(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.black,
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               Icon(Icons.wb_sunny, color: Colors.yellow), // Icône météo
//               SizedBox(width: 8),
//               Text(
//                 '28°C',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ],
//           ),
//           CircleAvatar(
//             radius: 18,
//             backgroundImage: NetworkImage(
//                 'https://example.com/profile.jpg'), // Ajouter une URL réelle ici
//             onBackgroundImageError: (_, __) {
//               Icon(Icons.person, color: Colors.white); // Si l'image échoue
//             },
//           ),
//         ],
//       ),
//       elevation: 0,
//     );
//   }
//
//   Widget _buildHeaderSection() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             'Electricity Usage',
//             style: TextStyle(fontSize: 18, color: Colors.white),
//           ),
//           Row(
//             children: [
//               Text('Weekly', style: TextStyle(color: Colors.white70)),
//               Switch(
//                 value: true,
//                 onChanged: (value) {},
//                 activeColor: Colors.purple,
//               ),
//               Text('Monthly', style: TextStyle(color: Colors.white70)),
//             ],
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _buildGraphSection() {
//     return Container(
//       height: 200,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: LineChart(
//           LineChartData(
//             gridData: FlGridData(show: false),
//             titlesData: FlTitlesData(show: false),
//             borderData: FlBorderData(show: false),
//             lineBarsData: [
//               LineChartBarData(
//                 spots: [
//                   FlSpot(0, 1),
//                   FlSpot(1, 3),
//                   FlSpot(2, 2),
//                   FlSpot(3, 5),
//                   FlSpot(4, 3),
//                   FlSpot(5, 4),
//                   FlSpot(6, 7),
//                 ],
//                 isCurved: true,
//                 colors: [Colors.purple],
//                 dotData: FlDotData(show: false),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStatsSection() {
//     return Expanded(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: GridView.count(
//           crossAxisCount: 2,
//           crossAxisSpacing: 16.0,
//           mainAxisSpacing: 16.0,
//           children: [
//             _buildStatCard('Electricity Cost', '\$415.31', Colors.purple),
//             _buildStatCard('Electricity Usage', '951.1 kW', Colors.orange),
//             _buildStatCard('Avg Monthly', '12,520 kW', Colors.blue),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStatCard(String title, String value, Color color) {
//     return Container(
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: TextStyle(color: Colors.white70),
//             ),
//             Spacer(),
//             Text(
//               value,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }