// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stopwatch_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StopwatchState _$StopwatchStateFromJson(Map<String, dynamic> json) {
  return _StopwatchState.fromJson(json);
}

/// @nodoc
mixin _$StopwatchState {
  StopwatchView get currentView => throw _privateConstructorUsedError;
  bool get isMuted => throw _privateConstructorUsedError;
  int get durationInSecs => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StopwatchStateCopyWith<StopwatchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StopwatchStateCopyWith<$Res> {
  factory $StopwatchStateCopyWith(
          StopwatchState value, $Res Function(StopwatchState) then) =
      _$StopwatchStateCopyWithImpl<$Res, StopwatchState>;
  @useResult
  $Res call({StopwatchView currentView, bool isMuted, int durationInSecs});
}

/// @nodoc
class _$StopwatchStateCopyWithImpl<$Res, $Val extends StopwatchState>
    implements $StopwatchStateCopyWith<$Res> {
  _$StopwatchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentView = null,
    Object? isMuted = null,
    Object? durationInSecs = null,
  }) {
    return _then(_value.copyWith(
      currentView: null == currentView
          ? _value.currentView
          : currentView // ignore: cast_nullable_to_non_nullable
              as StopwatchView,
      isMuted: null == isMuted
          ? _value.isMuted
          : isMuted // ignore: cast_nullable_to_non_nullable
              as bool,
      durationInSecs: null == durationInSecs
          ? _value.durationInSecs
          : durationInSecs // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_StopwatchStateCopyWith<$Res>
    implements $StopwatchStateCopyWith<$Res> {
  factory _$$_StopwatchStateCopyWith(
          _$_StopwatchState value, $Res Function(_$_StopwatchState) then) =
      __$$_StopwatchStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StopwatchView currentView, bool isMuted, int durationInSecs});
}

/// @nodoc
class __$$_StopwatchStateCopyWithImpl<$Res>
    extends _$StopwatchStateCopyWithImpl<$Res, _$_StopwatchState>
    implements _$$_StopwatchStateCopyWith<$Res> {
  __$$_StopwatchStateCopyWithImpl(
      _$_StopwatchState _value, $Res Function(_$_StopwatchState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentView = null,
    Object? isMuted = null,
    Object? durationInSecs = null,
  }) {
    return _then(_$_StopwatchState(
      currentView: null == currentView
          ? _value.currentView
          : currentView // ignore: cast_nullable_to_non_nullable
              as StopwatchView,
      isMuted: null == isMuted
          ? _value.isMuted
          : isMuted // ignore: cast_nullable_to_non_nullable
              as bool,
      durationInSecs: null == durationInSecs
          ? _value.durationInSecs
          : durationInSecs // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_StopwatchState implements _StopwatchState {
  const _$_StopwatchState(
      {required this.currentView,
      required this.isMuted,
      required this.durationInSecs});

  factory _$_StopwatchState.fromJson(Map<String, dynamic> json) =>
      _$$_StopwatchStateFromJson(json);

  @override
  final StopwatchView currentView;
  @override
  final bool isMuted;
  @override
  final int durationInSecs;

  @override
  String toString() {
    return 'StopwatchState(currentView: $currentView, isMuted: $isMuted, durationInSecs: $durationInSecs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StopwatchState &&
            (identical(other.currentView, currentView) ||
                other.currentView == currentView) &&
            (identical(other.isMuted, isMuted) || other.isMuted == isMuted) &&
            (identical(other.durationInSecs, durationInSecs) ||
                other.durationInSecs == durationInSecs));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, currentView, isMuted, durationInSecs);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StopwatchStateCopyWith<_$_StopwatchState> get copyWith =>
      __$$_StopwatchStateCopyWithImpl<_$_StopwatchState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StopwatchStateToJson(
      this,
    );
  }
}

abstract class _StopwatchState implements StopwatchState {
  const factory _StopwatchState(
      {required final StopwatchView currentView,
      required final bool isMuted,
      required final int durationInSecs}) = _$_StopwatchState;

  factory _StopwatchState.fromJson(Map<String, dynamic> json) =
      _$_StopwatchState.fromJson;

  @override
  StopwatchView get currentView;
  @override
  bool get isMuted;
  @override
  int get durationInSecs;
  @override
  @JsonKey(ignore: true)
  _$$_StopwatchStateCopyWith<_$_StopwatchState> get copyWith =>
      throw _privateConstructorUsedError;
}
