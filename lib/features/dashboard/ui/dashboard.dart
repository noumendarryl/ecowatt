import 'package:auto_route/annotations.dart';
import 'package:ecowatt/shared/widgets/BaseLayout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../shared/widgets/customAppBar.dart';
import '../logic/electricity_cubit.dart';
import '../logic/electricity_state.dart';
import '../model/electricity_data_model.dart';
import '../repository/electricity_repository.dart';


@RoutePage()
class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    String userId = user!.uid;
    context.read<ElectricityCubit>().loadElectricityData(userId);
  }
  @override
  Widget build(BuildContext context) {


    return BaseLayout(

      title: "DashBoard",
      currentIndex: 4,
      child:  BlocBuilder<ElectricityCubit, ElectricityState>(
        builder: (context, state) {
          return state.when(
            initial: () => Center(child: Text('Initial State')),
            loading: () => Center(child: CircularProgressIndicator()),
            loaded: (data) {
              double totalPower = calculateTotalPower(data);
              double cost = calculateCost(totalPower);
              double avgMonthly = calculateAverageMonthly(data);

              return Column(
                children: [
                  _buildHeaderSection(),
                  SizedBox(height: 20),
                  _buildGraphSection(data), // Ajoutez le graphique ici
                  SizedBox(height: 20),
                  _buildStatsSection(totalPower, cost, avgMonthly),
                ],
              );
            },
            error: (message) => Center(child: Text('Erreur : $message')),
          );
        },
      ),

    );
  }

  Widget _buildGraphSection(List<ElectricityDataModel> data) {
    // Regrouper les données par équipement
    Map<String, List<FlSpot>> equipmentData = {};

    for (var entry in data) {
      double xValue = entry.timestamp.millisecondsSinceEpoch / 3600000;
      if (!equipmentData.containsKey(entry.equipmentId)) {
        equipmentData[entry.equipmentId] = [];
        print(xValue);

      }
      equipmentData[entry.equipmentId]!.add(
        FlSpot(²//0entry.power, xValue)  ,

      );
    }

    return Container(
      height: 300,
      color: Color(0xFF1D1D1D), // Fond sombre
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Usage', // Titre
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(height: 4),
          Text(
            '13 May - 19 May',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true,getTitlesWidget: (value, meta) {
                    return Text(
                      value.toString(), // Afficher la valeur sur l'axe gauche
                      style: TextStyle(color: Colors.white),
                    );
                  },),),
                  bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true,getTitlesWidget: (value, meta) {
                    return Text(
                      value.toString(), // Afficher la valeur sur l'axe gauche
                      style: TextStyle(color: Colors.white),
                    );
                  },)),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: true),
                lineBarsData: equipmentData.entries.map((entry) {
                  return LineChartBarData(
                    spots: entry.value,
                    isCurved: true,
                    gradient: LinearGradient(
                      colors: [Colors.purple, Colors.purpleAccent], // Utilisez un dégradé ici
                    ),
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(show: false), // Si vous souhaitez afficher une zone sous la courbe
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, String title2) {
    return Container(
      decoration:
      BoxDecoration(color:
      color,
          borderRadius:
          BorderRadius.circular(16)),
      child:
      Padding(padding:
      const EdgeInsets.all(16.0),
          child:
          Column(crossAxisAlignment:
          CrossAxisAlignment.start,
            children:
            [
              Text(title, style:
              TextStyle(color:
              Colors.white70)),
              Spacer(),
              Text(value, style:
              TextStyle(color:
              Colors.white,
                  fontSize:
                  20,
                  fontWeight:
                  FontWeight.bold)),
              Spacer(),
              Text(title2, style:
              TextStyle(color:
              Colors.white70)),
            ],
          )),
    );
  }

  Widget _buildStatsSection(double totalPower, double cost, double avgMonthly) {
    return Expanded(
      child:
      Padding(padding:
      const EdgeInsets.all(16.0),
          child:
          GridView.count(crossAxisCount:
          2,
            crossAxisSpacing:
            16.0,
            mainAxisSpacing:
            16.0,
            children:
            [
              _buildStatCard('Electricity Cost', '\XAF ${cost.toStringAsFixed(2)}', Colors.purple, 'This Week'),
              _buildStatCard('Electricity Usage', '${totalPower.toStringAsFixed(2)} KWh', Colors.orange, 'This Week'),
              _buildStatCard('Avg Monthly', '${avgMonthly.toStringAsFixed(2)} KWh', Colors.blue, 'This Week'),
            ],
          )),
    );
  }

  Widget _buildHeaderSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Electricity Usage', style: TextStyle(fontSize: 18, color: Colors.white)),
          Row(
            children: [
              Text('Weekly', style: TextStyle(color: Colors.white70)),
              Switch(value: true, onChanged: (value) {}, activeColor: Colors.purple),
              Text('Monthly', style: TextStyle(color: Colors.white70)),
            ],
          )
        ],
      ),
    );
  }

  double calculateTotalPower(List<ElectricityDataModel> data) {
    return data.fold(0, (sum, item) => sum + item.power);
  }

  double calculateCost(double totalPower) {
    if (totalPower <= 100) {
      return totalPower * 50; // Coût par kWh
    } else if (totalPower <= 220) {
      return totalPower * 95; // Coût par kWh
    } else {
      return totalPower * 50; // Coût par kWh
    }
  }

  double calculateAverageMonthly(List<ElectricityDataModel> data) {
    if (data.isEmpty) return 0;

    double totalConsumption = data.fold(0, (sum, item) => sum + item.power);
    return totalConsumption / data.length;
  }
}