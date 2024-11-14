// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_measurement_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DeviceMeasurementModel _$DeviceMeasurementModelFromJson(
    Map<String, dynamic> json) {
  return _DeviceMeasurementModel.fromJson(json);
}

/// @nodoc
mixin _$DeviceMeasurementModel {
  double get voltage => throw _privateConstructorUsedError;
  double get power => throw _privateConstructorUsedError;
  String get mid => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this DeviceMeasurementModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeviceMeasurementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeviceMeasurementModelCopyWith<DeviceMeasurementModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceMeasurementModelCopyWith<$Res> {
  factory $DeviceMeasurementModelCopyWith(DeviceMeasurementModel value,
          $Res Function(DeviceMeasurementModel) then) =
      _$DeviceMeasurementModelCopyWithImpl<$Res, DeviceMeasurementModel>;
  @useResult
  $Res call(
      {double voltage, double power, String mid, DateTime timestamp});
}

/// @nodoc
class _$DeviceMeasurementModelCopyWithImpl<$Res,
        $Val extends DeviceMeasurementModel>
    implements $DeviceMeasurementModelCopyWith<$Res> {
  _$DeviceMeasurementModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeviceMeasurementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? voltage = null,
    Object? power = null,
    Object? mid = null,
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
      mid: null == mid
          ? _value.mid
          : mid // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeviceMeasurementModelImplCopyWith<$Res>
    implements $DeviceMeasurementModelCopyWith<$Res> {
  factory _$$DeviceMeasurementModelImplCopyWith(
          _$DeviceMeasurementModelImpl value,
          $Res Function(_$DeviceMeasurementModelImpl) then) =
      __$$DeviceMeasurementModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double voltage, double power, String mid, DateTime timestamp});
}

/// @nodoc
class __$$DeviceMeasurementModelImplCopyWithImpl<$Res>
    extends _$DeviceMeasurementModelCopyWithImpl<$Res,
        _$DeviceMeasurementModelImpl>
    implements _$$DeviceMeasurementModelImplCopyWith<$Res> {
  __$$DeviceMeasurementModelImplCopyWithImpl(
      _$DeviceMeasurementModelImpl _value,
      $Res Function(_$DeviceMeasurementModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeviceMeasurementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? voltage = null,
    Object? power = null,
    Object? mid = null,
    Object? timestamp = null,
  }) {
    return _then(_$DeviceMeasurementModelImpl(
      voltage: null == voltage
          ? _value.voltage
          : voltage // ignore: cast_nullable_to_non_nullable
              as double,
      power: null == power
          ? _value.power
          : power // ignore: cast_nullable_to_non_nullable
              as double,
      mid: null == mid
          ? _value.mid
          : mid // ignore: cast_nullable_to_non_nullable
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
class _$DeviceMeasurementModelImpl implements _DeviceMeasurementModel {
  const _$DeviceMeasurementModelImpl(
      {required this.voltage,
      required this.power,
      required this.mid,
      required this.timestamp});

  factory _$DeviceMeasurementModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeviceMeasurementModelImplFromJson(json);

  @override
  final double voltage;
  @override
  final double power;
  @override
  final String mid;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'DeviceMeasurementModel(voltage: $voltage, power: $power, mid: $mid, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceMeasurementModelImpl &&
            (identical(other.voltage, voltage) || other.voltage == voltage) &&
            (identical(other.power, power) || other.power == power) &&
            (identical(other.mid, mid) ||
                other.mid == mid) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, voltage, power, mid, timestamp);

  /// Create a copy of DeviceMeasurementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceMeasurementModelImplCopyWith<_$DeviceMeasurementModelImpl>
      get copyWith => __$$DeviceMeasurementModelImplCopyWithImpl<
          _$DeviceMeasurementModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeviceMeasurementModelImplToJson(
      this,
    );
  }
}

abstract class _DeviceMeasurementModel implements DeviceMeasurementModel {
  const factory _DeviceMeasurementModel(
      {required final double voltage,
      required final double power,
      required final String mid,
      required final DateTime timestamp}) = _$DeviceMeasurementModelImpl;

  factory _DeviceMeasurementModel.fromJson(Map<String, dynamic> json) =
      _$DeviceMeasurementModelImpl.fromJson;

  @override
  double get voltage;
  @override
  double get power;
  @override
  String get mid;
  @override
  DateTime get timestamp;

  /// Create a copy of DeviceMeasurementModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeviceMeasurementModelImplCopyWith<_$DeviceMeasurementModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
