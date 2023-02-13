// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jodo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Jodo _$JodoFromJson(Map<String, dynamic> json) {
  return _Jodo.fromJson(json);
}

/// @nodoc
mixin _$Jodo {
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String? get text => throw _privateConstructorUsedError;
  @JsonKey(name: 'completed_at')
  DateTime? get completedAt => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  JodoType get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JodoCopyWith<Jodo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JodoCopyWith<$Res> {
  factory $JodoCopyWith(Jodo value, $Res Function(Jodo) then) =
      _$JodoCopyWithImpl<$Res, Jodo>;
  @useResult
  $Res call(
      {String title,
      @JsonKey(name: 'description') String? text,
      @JsonKey(name: 'completed_at') DateTime? completedAt,
      int? id,
      DateTime? createdAt,
      JodoType type});
}

/// @nodoc
class _$JodoCopyWithImpl<$Res, $Val extends Jodo>
    implements $JodoCopyWith<$Res> {
  _$JodoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? text = freezed,
    Object? completedAt = freezed,
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as JodoType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_JodoCopyWith<$Res> implements $JodoCopyWith<$Res> {
  factory _$$_JodoCopyWith(_$_Jodo value, $Res Function(_$_Jodo) then) =
      __$$_JodoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      @JsonKey(name: 'description') String? text,
      @JsonKey(name: 'completed_at') DateTime? completedAt,
      int? id,
      DateTime? createdAt,
      JodoType type});
}

/// @nodoc
class __$$_JodoCopyWithImpl<$Res> extends _$JodoCopyWithImpl<$Res, _$_Jodo>
    implements _$$_JodoCopyWith<$Res> {
  __$$_JodoCopyWithImpl(_$_Jodo _value, $Res Function(_$_Jodo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? text = freezed,
    Object? completedAt = freezed,
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? type = null,
  }) {
    return _then(_$_Jodo(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as JodoType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Jodo extends _Jodo with DiagnosticableTreeMixin {
  const _$_Jodo(
      {required this.title,
      @JsonKey(name: 'description') this.text,
      @JsonKey(name: 'completed_at') this.completedAt,
      this.id,
      this.createdAt,
      required this.type})
      : super._();

  factory _$_Jodo.fromJson(Map<String, dynamic> json) => _$$_JodoFromJson(json);

  @override
  final String title;
  @override
  @JsonKey(name: 'description')
  final String? text;
  @override
  @JsonKey(name: 'completed_at')
  final DateTime? completedAt;
  @override
  final int? id;
  @override
  final DateTime? createdAt;
  @override
  final JodoType type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Jodo(title: $title, text: $text, completedAt: $completedAt, id: $id, createdAt: $createdAt, type: $type)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Jodo'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('text', text))
      ..add(DiagnosticsProperty('completedAt', completedAt))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('type', type));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Jodo &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, title, text, completedAt, id, createdAt, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_JodoCopyWith<_$_Jodo> get copyWith =>
      __$$_JodoCopyWithImpl<_$_Jodo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_JodoToJson(
      this,
    );
  }
}

abstract class _Jodo extends Jodo {
  const factory _Jodo(
      {required final String title,
      @JsonKey(name: 'description') final String? text,
      @JsonKey(name: 'completed_at') final DateTime? completedAt,
      final int? id,
      final DateTime? createdAt,
      required final JodoType type}) = _$_Jodo;
  const _Jodo._() : super._();

  factory _Jodo.fromJson(Map<String, dynamic> json) = _$_Jodo.fromJson;

  @override
  String get title;
  @override
  @JsonKey(name: 'description')
  String? get text;
  @override
  @JsonKey(name: 'completed_at')
  DateTime? get completedAt;
  @override
  int? get id;
  @override
  DateTime? get createdAt;
  @override
  JodoType get type;
  @override
  @JsonKey(ignore: true)
  _$$_JodoCopyWith<_$_Jodo> get copyWith => throw _privateConstructorUsedError;
}
