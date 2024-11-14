import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/device_measurement_repository.dart';

import 'device_measurement_state.dart';

class DeviceMeasurementCubit extends Cubit<DeviceMeasurementState> {
  final DeviceMeasurementRepository _repository;

  DeviceMeasurementCubit(this._repository) : super(const DeviceMeasurementState.initial());

  Future<void> loadDeviceMeasurement(String userId) async {
    try {
      emit(const DeviceMeasurementState.loading());

      // Charger les données depuis le repository
      final data = await _repository.fetchDeviceMeasurement(userId);

      if (data.isEmpty) {
        emit(const DeviceMeasurementState.error('No electricity data found.'));
        return; // Quitte la méthode si aucune donnée n'est trouvée
      }

      emit(DeviceMeasurementState.loaded(data));
    } catch (e) {
      emit(const DeviceMeasurementState.error('Failed to load electricity data. Please try again later.'));
      print('Error loading electricity data: ${e.toString()}'); // Log l'erreur pour le débogage
    }
  }
}