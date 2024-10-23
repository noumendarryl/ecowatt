// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'electricity_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ElectricityDataModel _$ElectricityDataModelFromJson(Map<String, dynamic> json) {
  return _ElectricityDataModel.fromJson(json);
}

/// @nodoc
mixin _$ElectricityDataModel {
  double get voltage => throw _privateConstructorUsedError;
  double get power => throw _privateConstructorUsedError;
  String get equipmentId => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this ElectricityDataModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ElectricityDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ElectricityDataModelCopyWith<ElectricityDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ElectricityDataModelCopyWith<$Res> {
  factory $ElectricityDataModelCopyWith(ElectricityDataModel value,
          $Res Function(ElectricityDataModel) then) =
      _$ElectricityDataModelCopyWithImpl<$Res, ElectricityDataModel>;
  @useResult
  $Res call(
      {double voltage, double power, String equipmentId, DateTime timestamp});
}

/// @nodoc
class _$ElectricityDataModelCopyWithImpl<$Res,
        $Val extends ElectricityDataModel>
    implements $ElectricityDataModelCopyWith<$Res> {
  _$ElectricityDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ElectricityDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? voltage = null,
    Object? power = null,
    Object? equipmentId = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      voltage: null == voltage
          ? _value.voltage
          : voltage // ignore: cast_nullable_to_non_nullable
              as double,
      power: null == power
          ? _value.power
          : power // ignore: cast_nullable_to_non_nullable
              as double,
      equipmentId: null == equipmentId
          ? _value.equipmentId
          : equipmentId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ElectricityDataModelImplCopyWith<$Res>
    implements $ElectricityDataModelCopyWith<$Res> {
  factory _$$ElectricityDataModelImplCopyWith(_$ElectricityDataModelImpl value,
          $Res Function(_$ElectricityDataModelImpl) then) =
      __$$ElectricityDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double voltage, double power, String equipmentId, DateTime timestamp});
}

/// @nodoc
class __$$ElectricityDataModelImplCopyWithImpl<$Res>
    extends _$ElectricityDataModelCopyWithImpl<$Res, _$ElectricityDataModelImpl>
    implements _$$ElectricityDataModelImplCopyWith<$Res> {
  __$$ElectricityDataModelImplCopyWithImpl(_$ElectricityDataModelImpl _value,
      $Res Function(_$ElectricityDataModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ElectricityDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? voltage = null,
    Object? power = null,
    Object? equipmentId = null,
    Object? timestamp = null,
  }) {
    return _then(_$ElectricityDataModelImpl(
      voltage: null == voltage
          ? _value.voltage
          : voltage // ignore: cast_nullable_to_non_nullable
              as double,
      power: null == power
          ? _value.power
          : power // ignore: cast_nullable_to_non_nullable
              as double,
      equipmentId: null == equipmentId
          ? _value.equipmentId
          : equipmentId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ElectricityDataModelImpl implements _ElectricityDataModel {
  const _$ElectricityDataModelImpl(
      {required this.voltage,
      required this.power,
      required this.equipmentId,
      required this.timestamp});

  factory _$ElectricityDataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ElectricityDataModelImplFromJson(json);

  @override
  final double voltage;
  @override
  final double power;
  @override
  final String equipmentId;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'ElectricityDataModel(voltage: $voltage, power: $power, equipmentId: $equipmentId, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ElectricityDataModelImpl &&
            (identical(other.voltage, voltage) || other.voltage == voltage) &&
            (identical(other.power, power) || other.power == power) &&
            (identical(other.equipmentId, equipmentId) ||
                other.equipmentId == equipmentId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, voltage, power, equipmentId, timestamp);

  /// Create a copy of ElectricityDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ElectricityDataModelImplCopyWith<_$ElectricityDataModelImpl>
      get copyWith =>
          __$$ElectricityDataModelImplCopyWithImpl<_$ElectricityDataModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ElectricityDataModelImplToJson(
      this,
    );
  }
}

abstract class _ElectricityDataModel implements ElectricityDataModel {
  const factory _ElectricityDataModel(
      {required final double voltage,
      required final double power,
      required final String equipmentId,
      required final DateTime timestamp}) = _$ElectricityDataModelImpl;

  factory _ElectricityDataModel.fromJson(Map<String, dynamic> json) =
      _$ElectricityDataModelImpl.fromJson;

  @override
  double get voltage;
  @override
  double get power;
  @override
  String get equipmentId;
  @override
  DateTime get timestamp;

  /// Create a copy of ElectricityDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ElectricityDataModelImplCopyWith<_$ElectricityDataModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
