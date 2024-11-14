import 'package:auto_route/annotations.dart';
import 'package:ecowatt/shared/constants/ui_helpers.dart';
import 'package:ecowatt/shared/widgets/base_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';

import '../logic/device_measurement_cubit.dart';
import '../logic/device_measurement_state.dart';
import '../models/device_measurement_model.dart';

@RoutePage()
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

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
    context.read<DeviceMeasurementCubit>().loadDeviceMeasurement(userId);
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: "DashBoard",
      currentIndex: 4,
      child: BlocBuilder<DeviceMeasurementCubit, DeviceMeasurementState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text('Initial State')),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (measurements) {
              double totalPower = calculateTotalPower(measurements);
              double cost = calculateCost(totalPower);
              double avgMonthly = calculateAverageMonthly(measurements);

              return Column(
                children: [
                  _buildHeaderSection(),
                  verticalSpaceMedium,
                  _buildGraphSection(measurements), // Ajoutez le graphique ici
                  verticalSpaceMedium,
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

  Widget _buildGraphSection(List<DeviceMeasurementModel> measurements) {
    // Regrouper les données par équipement
    Map<String, List<FlSpot>> devices = {};

    for (var entry in measurements) {
      double xValue = entry.timestamp.millisecondsSinceEpoch / 3600000;
      if (!devices.containsKey(entry.mid)) {
        devices[entry.mid] = [];
        print(xValue);
      }
      devices[entry.mid]!.add(
        FlSpot(entry.power, xValue),
      );
    }

    return Container(
      height: 300,
      color: Theme.of(context).colorScheme.scrim, // Fond sombre
      padding: const EdgeInsets.all(smallSize + 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Usage', // Titre
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface, fontSize: 16),
          ),
          verticalSpaceTiny,
          Text(
            '13 May - 19 May',
            style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary, fontSize: 12),
          ),
          verticalSpaceSmall,
          SizedBox(
            height: 200.0,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toString(),
                          // Afficher la valeur sur l'axe gauche
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toString(),
                        // Afficher la valeur sur l'axe gauche
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface),
                      );
                    },
                  )),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: true),
                lineBarsData: devices.entries.map((entry) {
                  return LineChartBarData(
                    spots: entry.value,
                    isCurved: true,
                    color: Theme.of(context).colorScheme.primary,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                        show:
                            false), // Si vous souhaitez afficher une zone sous la courbe
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(
      String title, String value, Color color, String subtitle) {
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.tertiary)),
              const Spacer(),
              Text(value,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                      fontWeight: FontWeight.bold)),
              const Spacer(),
              Text(subtitle,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.tertiary)),
            ],
          )),
    );
  }

  Widget _buildStatsSection(double totalPower, double cost, double avgMonthly) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            children: [
              _buildStatsCard(
                  'DeviceMeasurement Cost',
                  'XAF ${cost.toStringAsFixed(2)}',
                  Theme.of(context).colorScheme.primary,
                  'This Week'),
              _buildStatsCard(
                  'DeviceMeasurement Usage',
                  '${totalPower.toStringAsFixed(2)} KWh',
                  Theme.of(context).colorScheme.secondary,
                  'This Week'),
              _buildStatsCard(
                  'Avg Monthly',
                  '${avgMonthly.toStringAsFixed(2)} KWh',
                  Theme.of(context).colorScheme.outline,
                  'This Week'),
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
          Text('DeviceMeasurement Usage',
              style: TextStyle(
                  fontSize: 18, color: Theme.of(context).colorScheme.scrim)),
          Row(
            children: [
              Text('Weekly',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onTertiary)),
              Switch(
                  value: true,
                  onChanged: (newValue) {},
                  activeColor: Theme.of(context).colorScheme.primary),
              Text('Monthly',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onTertiary)),
            ],
          )
        ],
      ),
    );
  }

  double calculateTotalPower(List<DeviceMeasurementModel> measurements) {
    return measurements.fold(0, (sum, item) => sum + item.power);
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

  double calculateAverageMonthly(List<DeviceMeasurementModel> measurements) {
    if (measurements.isEmpty) return 0;

    double totalConsumption = measurements.fold(0, (sum, item) => sum + item.power);
    return totalConsumption / measurements.length;
  }
}
