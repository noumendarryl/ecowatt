import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/electricity_repository.dart';

import 'electricity_state.dart';

class ElectricityCubit extends Cubit<ElectricityState> {
  final ElectricityRepository _repository;

  ElectricityCubit(this._repository) : super(const ElectricityState.initial());

  Future<void> loadElectricityData(String userId) async {
    try {
      emit(const ElectricityState.loading());

      // Charger les données depuis le repository
      final data = await _repository.fetchElectricityData(userId);

      if (data.isEmpty) {
        emit(ElectricityState.error('No electricity data found.'));
        return; // Quitte la méthode si aucune donnée n'est trouvée
      }

      emit(ElectricityState.loaded(data));
    } catch (e) {
      emit(ElectricityState.error('Failed to load electricity data. Please try again later.'));
      print('Error loading electricity data: ${e.toString()}'); // Log l'erreur pour le débogage
    }
  }
}