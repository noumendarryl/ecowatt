import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/sensor_model.dart';

part 'sensor_state.freezed.dart';

@freezed
class SensorState with _$SensorState {
  const factory SensorState.initial() = _Initial;

  const factory SensorState.loading() = _Loading;

  const factory SensorState.loaded(List<SensorModel> sensors) = _Loaded;

  const factory SensorState.error(String message) = _Error;
}
