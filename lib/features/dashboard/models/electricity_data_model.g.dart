// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'electricity_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ElectricityDataModelImpl _$$ElectricityDataModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ElectricityDataModelImpl(
      voltage: (json['voltage'] as num).toDouble(),
      power: (json['power'] as num).toDouble(),
      equipmentId: json['equipmentId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$ElectricityDataModelImplToJson(
        _$ElectricityDataModelImpl instance) =>
    <String, dynamic>{
      'voltage': instance.voltage,
      'power': instance.power,
      'equipmentId': instance.equipmentId,
      'timestamp': instance.timestamp.toIso8601String(),
    };
