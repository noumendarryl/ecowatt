// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recommendation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RecommendationModel {
  String get rid => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  IconData get icon => throw _privateConstructorUsedError;
  List<String> get tips => throw _privateConstructorUsedError;
  String get impact => throw _privateConstructorUsedError;

  /// Create a copy of RecommendationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecommendationModelCopyWith<RecommendationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecommendationModelCopyWith<$Res> {
  factory $RecommendationModelCopyWith(
          RecommendationModel value, $Res Function(RecommendationModel) then) =
      _$RecommendationModelCopyWithImpl<$Res, RecommendationModel>;
  @useResult
  $Res call(
      {String rid,
      String title,
      String category,
      IconData icon,
      List<String> tips,
      String impact});
}

/// @nodoc
class _$RecommendationModelCopyWithImpl<$Res, $Val extends RecommendationModel>
    implements $RecommendationModelCopyWith<$Res> {
  _$RecommendationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecommendationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rid = null,
    Object? title = null,
    Object? category = null,
    Object? icon = null,
    Object? tips = null,
    Object? impact = null,
  }) {
    return _then(_value.copyWith(
      rid: null == rid
          ? _value.rid
          : rid // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData,
      tips: null == tips
          ? _value.tips
          : tips // ignore: cast_nullable_to_non_nullable
              as List<String>,
      impact: null == impact
          ? _value.impact
          : impact // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecommendationModelImplCopyWith<$Res>
    implements $RecommendationModelCopyWith<$Res> {
  factory _$$RecommendationModelImplCopyWith(_$RecommendationModelImpl value,
          $Res Function(_$RecommendationModelImpl) then) =
      __$$RecommendationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String rid,
      String title,
      String category,
      IconData icon,
      List<String> tips,
      String impact});
}

/// @nodoc
class __$$RecommendationModelImplCopyWithImpl<$Res>
    extends _$RecommendationModelCopyWithImpl<$Res, _$RecommendationModelImpl>
    implements _$$RecommendationModelImplCopyWith<$Res> {
  __$$RecommendationModelImplCopyWithImpl(_$RecommendationModelImpl _value,
      $Res Function(_$RecommendationModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecommendationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rid = null,
    Object? title = null,
    Object? category = null,
    Object? icon = null,
    Object? tips = null,
    Object? impact = null,
  }) {
    return _then(_$RecommendationModelImpl(
      rid: null == rid
          ? _value.rid
          : rid // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData,
      tips: null == tips
          ? _value._tips
          : tips // ignore: cast_nullable_to_non_nullable
              as List<String>,
      impact: null == impact
          ? _value.impact
          : impact // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RecommendationModelImpl implements _RecommendationModel {
  const _$RecommendationModelImpl(
      {required this.rid,
      required this.title,
      required this.category,
      required this.icon,
      required final List<String> tips,
      required this.impact})
      : _tips = tips;

  @override
  final String rid;
  @override
  final String title;
  @override
  final String category;
  @override
  final IconData icon;
  final List<String> _tips;
  @override
  List<String> get tips {
    if (_tips is EqualUnmodifiableListView) return _tips;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tips);
  }

  @override
  final String impact;

  @override
  String toString() {
    return 'RecommendationModel(rid: $rid, title: $title, category: $category, icon: $icon, tips: $tips, impact: $impact)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecommendationModelImpl &&
            (identical(other.rid, rid) || other.rid == rid) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            const DeepCollectionEquality().equals(other._tips, _tips) &&
            (identical(other.impact, impact) || other.impact == impact));
  }

  @override
  int get hashCode => Object.hash(runtimeType, rid, title, category, icon,
      const DeepCollectionEquality().hash(_tips), impact);

  /// Create a copy of RecommendationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecommendationModelImplCopyWith<_$RecommendationModelImpl> get copyWith =>
      __$$RecommendationModelImplCopyWithImpl<_$RecommendationModelImpl>(
          this, _$identity);
}

abstract class _RecommendationModel implements RecommendationModel {
  const factory _RecommendationModel(
      {required final String rid,
      required final String title,
      required final String category,
      required final IconData icon,
      required final List<String> tips,
      required final String impact}) = _$RecommendationModelImpl;

  @override
  String get rid;
  @override
  String get title;
  @override
  String get category;
  @override
  IconData get icon;
  @override
  List<String> get tips;
  @override
  String get impact;

  /// Create a copy of RecommendationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecommendationModelImplCopyWith<_$RecommendationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
