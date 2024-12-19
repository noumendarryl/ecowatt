import 'package:freezed_annotation/freezed_annotation.dart';

part 'sensor_model.freezed.dart';
part 'sensor_model.g.dart';

@freezed
class SensorModel with _$SensorModel {
  const factory SensorModel({
    required String sid,
    required String name,
    required String description,
  }) = _SensorModel;

  factory SensorModel.fromJson(Map<String, dynamic> json) =>
      _$SensorModelFromJson(json);
}