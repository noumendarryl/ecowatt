import 'package:auto_route/annotations.dart';
import 'package:ecowatt/shared/constants/ui_helpers.dart';
import 'package:ecowatt/shared/widgets/base_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../../../shared/utils/room_utils.dart';
import '../../device/logic/device_cubit.dart';
import '../../device/models/device_model.dart';
import '../../device/repositories/device_repository.dart';
import '../../home/models/room_model.dart';
import '../../home/repositories/room_repository.dart';
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
  // Add these class-level variables
  List<DeviceModel> devices = [];
  List<RoomModel> rooms = [];
  final List<String> dayLabels = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];
  String _selectedTimePeriod = 'Weekly';

  @override
  void initState() {
    super.initState();
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        context
            .read<DeviceMeasurementCubit>()
            .loadDeviceMeasurements(currentUser.uid);
        _fetchDevices();
        _fetchRooms();
      } else {
        print('No authenticated user found');
      }
    } catch (e) {
      print('Error initializing dashboard: $e');
    }
  }

  // Method to fetch data for rooms and devices
  Future<void> _fetchDevices() async {
    DeviceRepository deviceRepo = DeviceRepository();
    List<DeviceModel> fetchedDevices = await deviceRepo.getAllDevices();
    setState(() {
      devices = fetchedDevices;
    });
  }

  // Method to fetch data for rooms
  Future<void> _fetchRooms() async {
    RoomRepository roomRepo = RoomRepository();
    List<RoomModel> fetchedRooms = await roomRepo.getAllRooms();
    setState(() {
      rooms = fetchedRooms;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: "Dashboard",
      currentIndex: 4,
      child: BlocBuilder<DeviceMeasurementCubit, DeviceMeasurementState>(
        builder: (context, state) {
          return state.when(
              initial: () => const Center(child: Text('')),
              loading: () => Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary)),
              loaded: (measurements) {
                double totalPower = calculateTotalPower(measurements);
                double cost = calculateCost(totalPower);
                double avgMonthly = calculateAverageMonthly(measurements);

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: smallSize, vertical: mediumSize),
                    child: Column(
                      children: [
                        _buildGraphSection(measurements),
                        verticalSpaceMedium,
                        _buildStatsSection(totalPower, cost, avgMonthly),
                        verticalSpaceMedium,
                        _buildDeviceExpenseSection(measurements),
                        verticalSpaceMedium,
                        _buildRoomExpenseSection(measurements),
                      ],
                    ),
                  ),
                );
              },
              error: (message) => Center(
                    child: Padding(
                      padding: const EdgeInsets.all(smallSize),
                      child: Text(
                        message,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontFamily:
                              Theme.of(context).textTheme.bodySmall!.fontFamily,
                          fontSize:
                              Theme.of(context).textTheme.bodySmall!.fontSize,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ));
        },
      ),
    );
  }

  Widget _buildGraphSection(List<DeviceMeasurementModel> measurements) {
    // Determine date range and labels based on selected time period
    DateTime startDate, endDate;
    List<String> periodLabels;

    switch (_selectedTimePeriod) {
      case 'Daily':
        startDate = DateTime.now().subtract(const Duration(days: 1));
        endDate = DateTime.now();
        periodLabels = List.generate(24, (index) => '$index');
        break;
      case 'Weekly':
        final now = DateTime.now();
        startDate = now.subtract(Duration(days: now.weekday - 1));
        endDate = startDate.add(const Duration(days: 6));
        periodLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        break;
      case 'Monthly':
        final now = DateTime.now();
        startDate = DateTime(now.year, now.month, 1);
        endDate = DateTime(now.year, now.month + 1, 0);
        periodLabels =
            List.generate(endDate.day, (index) => (index + 1).toString());
        break;
      default:
        throw ArgumentError('Invalid time period');
    }

    // Filter measurements to the selected time period
    final filteredMeasurements = measurements.where((measurement) {
      return measurement.timestamp
              .isAfter(startDate.subtract(const Duration(days: 1))) &&
          measurement.timestamp.isBefore(endDate.add(const Duration(days: 1)));
    }).toList();

    // Group measurements by period
    Map<String, List<FlSpot>> periodData = {};
    for (var measurement in filteredMeasurements) {
      String periodKey = '';
      double xValue = 0.0;

      switch (_selectedTimePeriod) {
        case 'Daily':
          periodKey = '${measurement.timestamp.hour}:00';
          xValue = 0;
          break;
        case 'Weekly':
          periodKey = dayLabels[measurement.timestamp.weekday - 1];
          xValue = measurement.timestamp.weekday - 1.0;
          break;
        case 'Monthly':
          periodKey = measurement.timestamp.day.toString();
          xValue = measurement.timestamp.day - 1.0;
          break;
      }

      if (!periodData.containsKey(periodKey)) {
        periodData[periodKey] = [];
      }

      periodData[periodKey]!.add(FlSpot(xValue, measurement.power));
    }

    // Aggregate data points
    Map<String, double> aggregatedData = {};
    periodData.forEach((key, spots) {
      aggregatedData[key] = spots.map((spot) => spot.y).reduce((a, b) => a + b);
    });

    // Find max power for Y-axis scaling
    double maxPower = aggregatedData.values.fold(0, (a, b) => a > b ? a : b);

    print("Aggregated data : $aggregatedData");

    return Container(
      constraints: const BoxConstraints(
        minHeight: 200,
        maxHeight: 350,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(smallSize + 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Usage",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.scrim,
                    fontFamily:
                        Theme.of(context).textTheme.titleMedium!.fontFamily,
                    fontSize: 20.0,
                    fontWeight:
                        Theme.of(context).textTheme.titleMedium!.fontWeight),
              ),
              DropdownButton<String>(
                value: _selectedTimePeriod,
                items: ['Daily', 'Weekly', 'Monthly']
                    .map((period) => DropdownMenuItem(
                          value: period,
                          child: Text(period),
                        ))
                    .toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedTimePeriod = newValue;
                    });
                  }
                },
                dropdownColor: Theme.of(context).colorScheme.onTertiary,
                icon: Icon(Icons.keyboard_arrow_down,
                    color: Theme.of(context).colorScheme.tertiary),
                underline: Container(),
                // Remove underline
                style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontFamily:
                        Theme.of(context).textTheme.bodySmall!.fontFamily,
                    fontSize: 14.0,
                    fontWeight:
                        Theme.of(context).textTheme.bodySmall!.fontWeight),
              ),
            ],
          ),
          Text(
            '${DateFormat('dd MMM').format(startDate)} - ${DateFormat('dd MMM').format(endDate)}',
            style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontFamily: Theme.of(context).textTheme.labelSmall!.fontFamily,
                fontSize: 12.0,
                fontWeight: Theme.of(context).textTheme.labelSmall!.fontWeight),
          ),
          verticalSpaceMedium,
          Expanded(
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: periodLabels.length - 1.0,
                minY: 0,
                maxY: maxPower + 50,
                // Add some padding
                gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: true,
                  drawVerticalLine: false,
                  horizontalInterval: maxPower / 2,
                ),
                titlesData: _buildGraphTitles(periodLabels),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: aggregatedData.entries
                        .map((entry) => FlSpot(
                            periodLabels.indexOf(entry.key).toDouble(),
                            entry.value))
                        .toList(),
                    isCurved: true,
                    color: Theme.of(context).colorScheme.primary,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 6,
                          color: Theme.of(context).colorScheme.primary,
                          strokeWidth: 2,
                          strokeColor: Theme.of(context).colorScheme.onSurface,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    // tooltipBgColor: Theme.of(context).colorScheme.primary,
                    getTooltipItems: (List<LineBarSpot> touchedSpots) {
                      return touchedSpots.map((barSpot) {
                        return LineTooltipItem(
                          '${barSpot.y.toStringAsFixed(2)} KWh',
                          TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }).toList();
                    },
                  ),
                  handleBuiltInTouches: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  FlTitlesData _buildGraphTitles(List<String> periodLabels) {
    return FlTitlesData(
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 50,
          reservedSize: 30,
          getTitlesWidget: (value, meta) {
            return Text(value.toStringAsFixed(0),
                style: TextStyle(
                    color: Theme.of(context).colorScheme.scrim,
                    fontFamily:
                        Theme.of(context).textTheme.labelSmall!.fontFamily,
                    fontSize: 12.0,
                    fontWeight:
                        Theme.of(context).textTheme.labelSmall!.fontWeight));
          },
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: _selectedTimePeriod == 'Monthly'
              ? 3
              : _selectedTimePeriod == 'Weekly'
                  ? 1
                  : 2,
          getTitlesWidget: (value, meta) {
            return Text(
              value >= 0 && value < periodLabels.length
                  ? periodLabels[value.toInt()]
                  : '',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.scrim,
                  fontFamily:
                      Theme.of(context).textTheme.labelSmall!.fontFamily,
                  fontSize: 12.0,
                  fontWeight:
                      Theme.of(context).textTheme.labelSmall!.fontWeight),
            );
          },
        ),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    );
  }

  // Helper method to filter measurements
  List<DeviceMeasurementModel> _filterMeasurementsByPeriod(
      List<DeviceMeasurementModel> measurements) {
    DateTime startDate, endDate;

    switch (_selectedTimePeriod) {
      case 'Daily':
        startDate = DateTime.now().subtract(const Duration(days: 1));
        endDate = DateTime.now();
        break;
      case 'Weekly':
        final now = DateTime.now();
        startDate = now.subtract(Duration(days: now.weekday - 1));
        endDate = startDate.add(const Duration(days: 6));
        break;
      case 'Monthly':
        final now = DateTime.now();
        startDate = DateTime(now.year, now.month, 1);
        endDate = DateTime(now.year, now.month + 1, 0);
        break;
      default:
        throw ArgumentError('Invalid time period');
    }

    return measurements.where((measurement) {
      return measurement.timestamp
              .isAfter(startDate.subtract(const Duration(days: 1))) &&
          measurement.timestamp.isBefore(endDate.add(const Duration(days: 1)));
    }).toList();
  }

  // Updated calculation methods
  double calculateTotalPower(List<DeviceMeasurementModel> measurements) {
    final filteredMeasurements = _filterMeasurementsByPeriod(measurements);
    if (filteredMeasurements.isEmpty) return 0;
    return filteredMeasurements.fold(0, (sum, item) => sum + item.power);
  }

  double calculateCost(double totalPower) {
    // Cameroonian electricity tariff structure:
    // 0-110 kWh: 50 CFA/kWh (excluding VAT)
    // 111-220 kWh: 79 CFA/kWh (excluding VAT)
    // 221-400 kWh: 94 CFA/kWh (including VAT)
    // >400 kWh: 99 CFA/kWh (including VAT)

    double cost = 0;

    if (totalPower <= 110) {
      // First tier: 0-110 kWh at 50 CFA
      cost = totalPower * 50;
    } else if (totalPower <= 220) {
      // Second tier: first 110 kWh at 50 CFA, remainder at 79 CFA
      cost = (110 * 50) + ((totalPower - 110) * 79);
    } else if (totalPower <= 400) {
      // Third tier: first 110 kWh at 50 CFA, next 110 kWh at 79 CFA, remainder at 94 CFA
      cost = (110 * 50) + (110 * 79) + ((totalPower - 220) * 94);
    } else {
      // Fourth tier: first 110 kWh at 50 CFA, next 110 kWh at 79 CFA, next 180 kWh at 94 CFA, remainder at 99 CFA
      cost = (110 * 50) + (110 * 79) + (180 * 94) + ((totalPower - 400) * 99);
    }

    return cost;
  }

  double calculateAverageMonthly(List measurements) {
    if (measurements.isEmpty) return 0; // No data to calculate average

    // Filter measurements to include only those from the current month
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth =
        DateTime(now.year, now.month + 1, 0); // Last day of the current month

    final monthlyMeasurements = measurements.where((measurement) {
      return measurement.timestamp
              .isAfter(startOfMonth.subtract(Duration(days: 1))) &&
          measurement.timestamp.isBefore(endOfMonth.add(Duration(days: 1)));
    }).toList();

    // Calculate total power for the current month
    double totalMonthlyPower =
        monthlyMeasurements.fold(0, (sum, item) => sum + item.power);

    // Calculate the number of weeks in the current month
    int numberOfWeeks = (endOfMonth.day / 7)
        .ceil(); // This gives the number of weeks in the month

    // Calculate average consumed power per week
    double averageMonthlyPower = totalMonthlyPower / numberOfWeeks;

    return averageMonthlyPower; // Return average consumed power per week
  }

  Widget _buildStatsSection(double totalPower, double cost, double avgMonthly) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(smallSize + 6.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildStatsCard(
                    'Electricity Cost',
                    'XAF ${cost.toStringAsFixed(2) ?? 0.00}',
                    Theme.of(context).colorScheme.primary,
                    _selectedTimePeriod == 'Monthly'
                        ? 'This Month'
                        : _selectedTimePeriod == 'Weekly'
                            ? 'This Week'
                            : 'This Day',
                  ),
                ),
                horizontalSpaceSmall,
                Expanded(
                  child: _buildStatsCard(
                    'Electricity Usage',
                    '${totalPower.toStringAsFixed(2) ?? 0.00} KWh',
                    Theme.of(context).colorScheme.secondary,
                    _selectedTimePeriod == 'Monthly'
                        ? 'This Month'
                        : _selectedTimePeriod == 'Weekly'
                            ? 'This Week'
                            : 'This Day',
                  ),
                ),
              ],
            ),
            verticalSpaceSmall,
            _buildStatsCard(
              'Avg Monthly',
              '${avgMonthly.toStringAsFixed(2) ?? 0.00} KWh',
              const Color(0xFFB395FF),
              'This Month',
              fullWidth: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard(
    String title,
    String value,
    Color color,
    String subtitle, {
    bool fullWidth = false,
  }) {
    return Container(
      width: fullWidth ? double.infinity : null,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(smallSize + 6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpaceMedium,
            Text(
              value,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpaceSmall,
            Text(
              subtitle,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceExpenseSection(List<DeviceMeasurementModel> measurements) {
  // First, create a map of sensor to power consumption
  Map<String, double> sensorPowerMap = {};
  for (var measurement in measurements) {
    if (sensorPowerMap.containsKey(measurement.sid)) {
      sensorPowerMap[measurement.sid] = sensorPowerMap[measurement.sid]! + measurement.power;
    } else {
      sensorPowerMap[measurement.sid] = measurement.power;
    }
  }

  // Now map sensor power to devices using the sid in DeviceModel
  Map<String, double> devicePowerMap = {};
  for (var device in devices) {
    if (device.sid != null && sensorPowerMap.containsKey(device.sid)) {
      devicePowerMap[device.name] = sensorPowerMap[device.sid]!;
    }
  }

  // Sort devices by power consumption and get top 5
  var sortedDevices = devicePowerMap.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));
  var top5Devices = sortedDevices.take(5).toList();

  // Find the maximum power for scaling the progress bars
  double maxPower = top5Devices.isNotEmpty ? top5Devices.first.value : 100;

  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.onSurface,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    padding: const EdgeInsets.all(smallSize + 6.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Expenses from devices",
          style: TextStyle(
            color: Theme.of(context).colorScheme.scrim,
            fontFamily: Theme.of(context).textTheme.titleMedium!.fontFamily,
            fontSize: 20.0,
            fontWeight: Theme.of(context).textTheme.titleMedium!.fontWeight
          ),
        ),
        verticalSpaceMedium,
        if (top5Devices.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: Text(
                'No device measurements available',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontFamily: Theme.of(context).textTheme.bodySmall!.fontFamily,
                  fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                  fontWeight: Theme.of(context).textTheme.bodySmall!.fontWeight
                ),
              ),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: top5Devices.length,
            separatorBuilder: (context, index) => verticalSpaceSmall,
            itemBuilder: (context, index) {
              var deviceEntry = top5Devices[index];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          deviceEntry.key, // Using device name directly
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontFamily: Theme.of(context).textTheme.titleSmall!.fontFamily,
                            fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '${deviceEntry.value.toStringAsFixed(1)}W',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontFamily: Theme.of(context).textTheme.labelSmall!.fontFamily,
                          fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  verticalSpaceSmall,
                  Stack(
                    children: [
                      Container(
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      Container(
                        height: 12,
                        width: (deviceEntry.value / maxPower) *
                            MediaQuery.of(context).size.width *
                            0.7,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
      ],
    ),
  );
}

Widget _buildRoomExpenseSection(List<DeviceMeasurementModel> measurements) {
  // First, create a map of sensor to power consumption
  Map<String, double> sensorPowerMap = {};
  for (var measurement in measurements) {
    if (sensorPowerMap.containsKey(measurement.sid)) {
      sensorPowerMap[measurement.sid] = sensorPowerMap[measurement.sid]! + measurement.power;
    } else {
      sensorPowerMap[measurement.sid] = measurement.power;
    }
  }

  // Map sensor power to devices, then aggregate by room
  Map<String, double> roomPowerMap = {};
  for (var device in devices) {
    if (device.sid != null && sensorPowerMap.containsKey(device.sid)) {
      if (roomPowerMap.containsKey(device.rid)) {
        roomPowerMap[device.rid] = roomPowerMap[device.rid]! + sensorPowerMap[device.sid]!;
      } else {
        roomPowerMap[device.rid] = sensorPowerMap[device.sid]!;
      }
    }
  }

  // Sort rooms by power consumption and get top 4
  var sortedRooms = roomPowerMap.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));
  var top4Rooms = sortedRooms.take(4).toList();

  // Find the maximum power for scaling the progress bars
  double maxPower = top4Rooms.isNotEmpty ? top4Rooms.first.value : 100;

  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.onSurface,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    padding: const EdgeInsets.all(smallSize + 6.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Expenses from rooms",
          style: TextStyle(
            color: Theme.of(context).colorScheme.scrim,
            fontFamily: Theme.of(context).textTheme.titleMedium!.fontFamily,
            fontSize: 20.0,
            fontWeight: Theme.of(context).textTheme.titleMedium!.fontWeight
          ),
        ),
        verticalSpaceMedium,
        if (top4Rooms.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: Text(
                'No room measurements available',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontFamily: Theme.of(context).textTheme.bodySmall!.fontFamily,
                  fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                  fontWeight: Theme.of(context).textTheme.bodySmall!.fontWeight
                ),
              ),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: top4Rooms.length,
            separatorBuilder: (context, index) => verticalSpaceMedium,
            itemBuilder: (context, index) {
              var roomEntry = top4Rooms[index];
              var room = rooms.firstWhere(
                (r) => r.rid == roomEntry.key,
                orElse: () => RoomModel(
                  rid: roomEntry.key,
                  name: 'Unknown Room',
                ),
              );

              Color roomColor = RoomUtils.generateStaticRandomColor(room.name ?? '');
              IconData roomIcon = RoomUtils().getCardIcon(room.name);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          room.name,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontFamily: Theme.of(context).textTheme.titleSmall!.fontFamily,
                            fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '${roomEntry.value.toStringAsFixed(1)}W',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontFamily: Theme.of(context).textTheme.labelSmall!.fontFamily,
                          fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Container(
                        height: 50,
                        width: (roomEntry.value / maxPower) *
                            MediaQuery.of(context).size.width *
                            0.7,
                        decoration: BoxDecoration(
                          color: roomColor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      Positioned(
                        left: 8,
                        bottom: 8,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            roomIcon,
                            color: roomColor,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
      ],
    ),
  );
}
}
