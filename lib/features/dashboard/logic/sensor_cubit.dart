import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import '../repositories/sensor_repository.dart';
import 'sensor_state.dart';

class SensorCubit extends Cubit<SensorState> {
  final SensorRepository _repository;

  SensorCubit(this._repository) : super(const SensorState.initial());

  Future<void> loadAllSensors() async {
    try {
      emit(const SensorState.loading());

      debugPrint('Loading all sensors');

      final sensors = await _repository.getAllSensors();

      debugPrint('Sensors loaded: ${sensors.length}');

      if (sensors.isEmpty) {
        debugPrint('No sensors found');
        emit(const SensorState.error('No sensors found'));
        return;
      }

      emit(SensorState.loaded(sensors));
    } catch (e) {
      debugPrint('Error loading sensors : $e');
      emit(SensorState.error('Failed to load sensors : ${e.toString()}'));
    }
  }

  Future<void> loadSensorById(String sensorId) async {
    try {
      emit(const SensorState.loading());

      debugPrint('Loading sensor with ID : $sensorId');

      final sensor = await _repository.getSensorById(sensorId);

      if (sensor == null) {
        debugPrint('No sensor found with ID : $sensorId');
        emit(const SensorState.error('Sensor not found'));
        return;
      }

      emit(SensorState.loaded([sensor]));
    } catch (e) {
      debugPrint('Error loading sensor : $e');
      emit(SensorState.error('Failed to load sensor : ${e.toString()}'));
    }
  }
}