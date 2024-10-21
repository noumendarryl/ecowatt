import 'package:freezed_annotation/freezed_annotation.dart';

import '../model/electricity_data_model.dart';


part 'electricity_state.freezed.dart';


@freezed
class ElectricityState with _$ElectricityState {
  const factory ElectricityState.initial() = _Initial;
  const factory ElectricityState.loading() = _Loading;
  const factory ElectricityState.loaded(List<ElectricityDataModel> data) = _Loaded;
  const factory ElectricityState.error(String message) = _Error;
}