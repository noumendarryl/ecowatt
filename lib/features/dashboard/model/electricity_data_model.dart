import 'package:freezed_annotation/freezed_annotation.dart';

part 'electricity_data_model.freezed.dart';
part 'electricity_data_model.g.dart';

@freezed
class ElectricityDataModel with _$ElectricityDataModel {
  const factory ElectricityDataModel({
    required double voltage,
    required double power,
    required String equipmentId,
    required DateTime timestamp,
  }) = _ElectricityDataModel;

  factory ElectricityDataModel.fromJson(Map<String, dynamic> json) => _$ElectricityDataModelFromJson(json);
}