// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProfileStateInit _$$_ProfileStateInitFromJson(Map<String, dynamic> json) =>
    _$_ProfileStateInit(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_ProfileStateInitToJson(_$_ProfileStateInit instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$_ProfileStateLoading _$$_ProfileStateLoadingFromJson(
        Map<String, dynamic> json) =>
    _$_ProfileStateLoading(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_ProfileStateLoadingToJson(
        _$_ProfileStateLoading instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$_ProfileStateLoaded _$$_ProfileStateLoadedFromJson(
        Map<String, dynamic> json) =>
    _$_ProfileStateLoaded(
      UserProfile.fromJson(json['userProfile'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_ProfileStateLoadedToJson(
        _$_ProfileStateLoaded instance) =>
    <String, dynamic>{
      'userProfile': instance.userProfile,
      'runtimeType': instance.$type,
    };

_$_ProfileStateError _$$_ProfileStateErrorFromJson(Map<String, dynamic> json) =>
    _$_ProfileStateError(
      json['userProfile'] == null
          ? null
          : UserProfile.fromJson(json['userProfile'] as Map<String, dynamic>),
      json['error'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_ProfileStateErrorToJson(
        _$_ProfileStateError instance) =>
    <String, dynamic>{
      'userProfile': instance.userProfile,
      'error': instance.error,
      'runtimeType': instance.$type,
    };
