import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_measurement_model.freezed.dart';
part 'device_measurement_model.g.dart';

@freezed
class DeviceMeasurementModel with _$DeviceMeasurementModel {
  const factory DeviceMeasurementModel({
    required String mid,
    required String sid,
    required double power,
    required DateTime timestamp,
  }) = _DeviceMeasurementModel;

  factory DeviceMeasurementModel.fromJson(Map<String, dynamic> json) => _$DeviceMeasurementModelFromJson(json);
}
