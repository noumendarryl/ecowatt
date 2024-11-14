// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_measurement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeviceMeasurementModelImpl _$$DeviceMeasurementModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DeviceMeasurementModelImpl(
      voltage: (json['voltage'] as num).toDouble(),
      power: (json['power'] as num).toDouble(),
      mid: json['mid'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$DeviceMeasurementModelImplToJson(
        _$DeviceMeasurementModelImpl instance) =>
    <String, dynamic>{
      'voltage': instance.voltage,
      'power': instance.power,
      'mid': instance.mid,
      'timestamp': instance.timestamp.toIso8601String(),
    };
