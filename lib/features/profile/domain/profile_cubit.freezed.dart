// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'profile_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProfileState _$ProfileStateFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'initial':
      return _ProfileStateInit.fromJson(json);
    case 'loading':
      return _ProfileStateLoading.fromJson(json);
    case 'loaded':
      return _ProfileStateLoaded.fromJson(json);
    case 'error':
      return _ProfileStateError.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'ProfileState',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$ProfileState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserProfile userProfile) loaded,
    required TResult Function(UserProfile? userProfile, String error) error,
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserProfile userProfile)? loaded,
    TResult? Function(UserProfile? userProfile, String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserProfile userProfile)? loaded,
    TResult Function(UserProfile? userProfile, String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProfileStateInit value) initial,
    required TResult Function(_ProfileStateLoading value) loading,
    required TResult Function(_ProfileStateLoaded value) loaded,
    required TResult Function(_ProfileStateError value) error,
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ProfileStateInit value)? initial,
    TResult? Function(_ProfileStateLoading value)? loading,
    TResult? Function(_ProfileStateLoaded value)? loaded,
    TResult? Function(_ProfileStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProfileStateInit value)? initial,
    TResult Function(_ProfileStateLoading value)? loading,
    TResult Function(_ProfileStateLoaded value)? loaded,
    TResult Function(_ProfileStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileStateCopyWith<$Res> {
  factory $ProfileStateCopyWith(
          ProfileState value, $Res Function(ProfileState) then) =
      _$ProfileStateCopyWithImpl<$Res, ProfileState>;
}

/// @nodoc
class _$ProfileStateCopyWithImpl<$Res, $Val extends ProfileState>
    implements $ProfileStateCopyWith<$Res> {
  _$ProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;

  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_ProfileStateInitCopyWith<$Res> {
  factory _$$_ProfileStateInitCopyWith(
          _$_ProfileStateInit value, $Res Function(_$_ProfileStateInit) then) =
      __$$_ProfileStateInitCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_ProfileStateInitCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res, _$_ProfileStateInit>
    implements _$$_ProfileStateInitCopyWith<$Res> {
  __$$_ProfileStateInitCopyWithImpl(
      _$_ProfileStateInit _value, $Res Function(_$_ProfileStateInit) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$_ProfileStateInit implements _ProfileStateInit {
  _$_ProfileStateInit({final String? $type}) : $type = $type ?? 'initial';

  factory _$_ProfileStateInit.fromJson(Map<String, dynamic> json) =>
      _$$_ProfileStateInitFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ProfileState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_ProfileStateInit);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserProfile userProfile) loaded,
    required TResult Function(UserProfile? userProfile, String error) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserProfile userProfile)? loaded,
    TResult? Function(UserProfile? userProfile, String error)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserProfile userProfile)? loaded,
    TResult Function(UserProfile? userProfile, String error)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProfileStateInit value) initial,
    required TResult Function(_ProfileStateLoading value) loading,
    required TResult Function(_ProfileStateLoaded value) loaded,
    required TResult Function(_ProfileStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ProfileStateInit value)? initial,
    TResult? Function(_ProfileStateLoading value)? loading,
    TResult? Function(_ProfileStateLoaded value)? loaded,
    TResult? Function(_ProfileStateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProfileStateInit value)? initial,
    TResult Function(_ProfileStateLoading value)? loading,
    TResult Function(_ProfileStateLoaded value)? loaded,
    TResult Function(_ProfileStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProfileStateInitToJson(
      this,
    );
  }
}

abstract class _ProfileStateInit implements ProfileState {
  factory _ProfileStateInit() = _$_ProfileStateInit;

  factory _ProfileStateInit.fromJson(Map<String, dynamic> json) =
      _$_ProfileStateInit.fromJson;
}

/// @nodoc
abstract class _$$_ProfileStateLoadingCopyWith<$Res> {
  factory _$$_ProfileStateLoadingCopyWith(_$_ProfileStateLoading value,
          $Res Function(_$_ProfileStateLoading) then) =
      __$$_ProfileStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_ProfileStateLoadingCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res, _$_ProfileStateLoading>
    implements _$$_ProfileStateLoadingCopyWith<$Res> {
  __$$_ProfileStateLoadingCopyWithImpl(_$_ProfileStateLoading _value,
      $Res Function(_$_ProfileStateLoading) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$_ProfileStateLoading implements _ProfileStateLoading {
  _$_ProfileStateLoading({final String? $type}) : $type = $type ?? 'loading';

  factory _$_ProfileStateLoading.fromJson(Map<String, dynamic> json) =>
      _$$_ProfileStateLoadingFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ProfileState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_ProfileStateLoading);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserProfile userProfile) loaded,
    required TResult Function(UserProfile? userProfile, String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserProfile userProfile)? loaded,
    TResult? Function(UserProfile? userProfile, String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserProfile userProfile)? loaded,
    TResult Function(UserProfile? userProfile, String error)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProfileStateInit value) initial,
    required TResult Function(_ProfileStateLoading value) loading,
    required TResult Function(_ProfileStateLoaded value) loaded,
    required TResult Function(_ProfileStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ProfileStateInit value)? initial,
    TResult? Function(_ProfileStateLoading value)? loading,
    TResult? Function(_ProfileStateLoaded value)? loaded,
    TResult? Function(_ProfileStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProfileStateInit value)? initial,
    TResult Function(_ProfileStateLoading value)? loading,
    TResult Function(_ProfileStateLoaded value)? loaded,
    TResult Function(_ProfileStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProfileStateLoadingToJson(
      this,
    );
  }
}

abstract class _ProfileStateLoading implements ProfileState {
  factory _ProfileStateLoading() = _$_ProfileStateLoading;

  factory _ProfileStateLoading.fromJson(Map<String, dynamic> json) =
      _$_ProfileStateLoading.fromJson;
}

/// @nodoc
abstract class _$$_ProfileStateLoadedCopyWith<$Res> {
  factory _$$_ProfileStateLoadedCopyWith(_$_ProfileStateLoaded value,
          $Res Function(_$_ProfileStateLoaded) then) =
      __$$_ProfileStateLoadedCopyWithImpl<$Res>;

  @useResult
  $Res call({UserProfile userProfile});
}

/// @nodoc
class __$$_ProfileStateLoadedCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res, _$_ProfileStateLoaded>
    implements _$$_ProfileStateLoadedCopyWith<$Res> {
  __$$_ProfileStateLoadedCopyWithImpl(
      _$_ProfileStateLoaded _value, $Res Function(_$_ProfileStateLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userProfile = null,
  }) {
    return _then(_$_ProfileStateLoaded(
      null == userProfile
          ? _value.userProfile
          : userProfile // ignore: cast_nullable_to_non_nullable
              as UserProfile,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProfileStateLoaded implements _ProfileStateLoaded {
  _$_ProfileStateLoaded(this.userProfile, {final String? $type})
      : $type = $type ?? 'loaded';

  factory _$_ProfileStateLoaded.fromJson(Map<String, dynamic> json) =>
      _$$_ProfileStateLoadedFromJson(json);

  @override
  final UserProfile userProfile;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ProfileState.loaded(userProfile: $userProfile)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProfileStateLoaded &&
            (identical(other.userProfile, userProfile) ||
                other.userProfile == userProfile));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userProfile);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProfileStateLoadedCopyWith<_$_ProfileStateLoaded> get copyWith =>
      __$$_ProfileStateLoadedCopyWithImpl<_$_ProfileStateLoaded>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserProfile userProfile) loaded,
    required TResult Function(UserProfile? userProfile, String error) error,
  }) {
    return loaded(userProfile);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserProfile userProfile)? loaded,
    TResult? Function(UserProfile? userProfile, String error)? error,
  }) {
    return loaded?.call(userProfile);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserProfile userProfile)? loaded,
    TResult Function(UserProfile? userProfile, String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(userProfile);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProfileStateInit value) initial,
    required TResult Function(_ProfileStateLoading value) loading,
    required TResult Function(_ProfileStateLoaded value) loaded,
    required TResult Function(_ProfileStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ProfileStateInit value)? initial,
    TResult? Function(_ProfileStateLoading value)? loading,
    TResult? Function(_ProfileStateLoaded value)? loaded,
    TResult? Function(_ProfileStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProfileStateInit value)? initial,
    TResult Function(_ProfileStateLoading value)? loading,
    TResult Function(_ProfileStateLoaded value)? loaded,
    TResult Function(_ProfileStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProfileStateLoadedToJson(
      this,
    );
  }
}

abstract class _ProfileStateLoaded implements ProfileState {
  factory _ProfileStateLoaded(final UserProfile userProfile) =
      _$_ProfileStateLoaded;

  factory _ProfileStateLoaded.fromJson(Map<String, dynamic> json) =
      _$_ProfileStateLoaded.fromJson;

  UserProfile get userProfile;

  @JsonKey(ignore: true)
  _$$_ProfileStateLoadedCopyWith<_$_ProfileStateLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ProfileStateErrorCopyWith<$Res> {
  factory _$$_ProfileStateErrorCopyWith(_$_ProfileStateError value,
          $Res Function(_$_ProfileStateError) then) =
      __$$_ProfileStateErrorCopyWithImpl<$Res>;

  @useResult
  $Res call({UserProfile? userProfile, String error});
}

/// @nodoc
class __$$_ProfileStateErrorCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res, _$_ProfileStateError>
    implements _$$_ProfileStateErrorCopyWith<$Res> {
  __$$_ProfileStateErrorCopyWithImpl(
      _$_ProfileStateError _value, $Res Function(_$_ProfileStateError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userProfile = freezed,
    Object? error = null,
  }) {
    return _then(_$_ProfileStateError(
      freezed == userProfile
          ? _value.userProfile
          : userProfile // ignore: cast_nullable_to_non_nullable
              as UserProfile?,
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProfileStateError implements _ProfileStateError {
  _$_ProfileStateError(this.userProfile, this.error, {final String? $type})
      : $type = $type ?? 'error';

  factory _$_ProfileStateError.fromJson(Map<String, dynamic> json) =>
      _$$_ProfileStateErrorFromJson(json);

  @override
  final UserProfile? userProfile;
  @override
  final String error;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ProfileState.error(userProfile: $userProfile, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProfileStateError &&
            (identical(other.userProfile, userProfile) ||
                other.userProfile == userProfile) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userProfile, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProfileStateErrorCopyWith<_$_ProfileStateError> get copyWith =>
      __$$_ProfileStateErrorCopyWithImpl<_$_ProfileStateError>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserProfile userProfile) loaded,
    required TResult Function(UserProfile? userProfile, String error) error,
  }) {
    return error(userProfile, this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserProfile userProfile)? loaded,
    TResult? Function(UserProfile? userProfile, String error)? error,
  }) {
    return error?.call(userProfile, this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserProfile userProfile)? loaded,
    TResult Function(UserProfile? userProfile, String error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(userProfile, this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProfileStateInit value) initial,
    required TResult Function(_ProfileStateLoading value) loading,
    required TResult Function(_ProfileStateLoaded value) loaded,
    required TResult Function(_ProfileStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ProfileStateInit value)? initial,
    TResult? Function(_ProfileStateLoading value)? loading,
    TResult? Function(_ProfileStateLoaded value)? loaded,
    TResult? Function(_ProfileStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProfileStateInit value)? initial,
    TResult Function(_ProfileStateLoading value)? loading,
    TResult Function(_ProfileStateLoaded value)? loaded,
    TResult Function(_ProfileStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProfileStateErrorToJson(
      this,
    );
  }
}

abstract class _ProfileStateError implements ProfileState {
  factory _ProfileStateError(
          final UserProfile? userProfile, final String error) =
      _$_ProfileStateError;

  factory _ProfileStateError.fromJson(Map<String, dynamic> json) =
      _$_ProfileStateError.fromJson;

  UserProfile? get userProfile;

  String get error;

  @JsonKey(ignore: true)
  _$$_ProfileStateErrorCopyWith<_$_ProfileStateError> get copyWith =>
      throw _privateConstructorUsedError;
}
